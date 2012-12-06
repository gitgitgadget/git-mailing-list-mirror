From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Exploiting SHA1's "XOR weakness" allows for faster hash calculation
Date: Thu, 6 Dec 2012 09:11:29 +0100
Message-ID: <CAHGBnuN1AwjAFeJMizXu9e-iD3n1GuWMNm9OPxCH7t1BcGz8Rw@mail.gmail.com>
References: <k9n3jd$akg$1@ger.gmane.org>
	<20121205172011.GH18885@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 06 09:11:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgWYc-0003kj-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 09:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab2LFILa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 03:11:30 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52862 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab2LFILa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 03:11:30 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so5630545vcd.19
        for <git@vger.kernel.org>; Thu, 06 Dec 2012 00:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D0mG/dGfav5ZEb5xWnmwJ9DLThRF8vzEMwJ36JPKzhg=;
        b=aByICNBUkx49uqCS4nUWgEnRy/XLRv2QU+XsDkZNpYcbHJljyL/mF0mJantVq2bCZ2
         K7G1/PqhVjKOz+K4+zQ9HwiZixT5JQ1gI/HdTVPmL5lHTGZVaO5xlLCZbpj6jZ5TUdrG
         QRosMaBpC2wkBYgZ4i7Sl+LN+yv8pWrgyhSfDYJ2NLKDCQqtUlW+uC3Hw28cdBhZefxQ
         A9B493owraiK/QICZYRjkDAzJM1KxT3IcWCdh0fFiyg0ZI3BVT/kSZsL0GHCKfM4jcF7
         DiGtUjQlm6BCMuQEcKBwiVKY88hBgq20EFrNwjyZe74AM9BX+7JZkOWeAYkiMF4sAGY9
         rO7g==
Received: by 10.52.89.132 with SMTP id bo4mr335799vdb.80.1354781489316; Thu,
 06 Dec 2012 00:11:29 -0800 (PST)
Received: by 10.58.64.43 with HTTP; Thu, 6 Dec 2012 00:11:29 -0800 (PST)
In-Reply-To: <20121205172011.GH18885@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211158>

On Wed, Dec 5, 2012 at 6:20 PM, Theodore Ts'o <tytso@mit.edu> wrote:

> It's only useful if you are trying to do brute-force password
> cracking, where the password is being hashed in a very specific way.
> (If for example the password was replicated N times in the input
> buffer for SHA-1, instead of keeping the padding constant in the rest
> of theinput buffer, this particular optimization would't apply.)
>
> In any case, it's not at all applicable for general purpose checksum
> calculations, and hence wouldn't apply to git.

Thanks for the explanation.

-- 
Sebastian Schuberth
