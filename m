From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: restoring all branches from a bundle
Date: Fri, 24 May 2013 18:42:37 +0700
Message-ID: <CACsJy8C6C1GpTts+n+5Bs=aFbAgRCaQ5K8c+kr1ux0tjUbbgeQ@mail.gmail.com>
References: <519F4684.7010905@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Frb3MsIFRhanRp?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Fri May 24 13:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfqOv-0004bF-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 13:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab3EXLnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 07:43:09 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:36004 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab3EXLnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 07:43:08 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so5888966oag.4
        for <git@vger.kernel.org>; Fri, 24 May 2013 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wNdbczbmQ8nFMfHKOAAFQttUIgayObq+HoZp0jj1GJo=;
        b=Ho+ySZl4jFNOXGtHhmgUWf5jG9yijkTSU5CUoXSMhJIg53Xnn37Le+aoCivdEMpNEQ
         I06yeBiBoFVL8A1+OugDStqnvl1LD2ZjiphqIk8IncRF3mBcF6RsHsD/pJKQUZbpOOea
         WepuUI1PUoYrtrRK88madY5fzKSPFKHjOPyPWPVXNEF+yOvELov6EGyTnYYEpEAptC0R
         hzOnLShNdQoEHLgMeuPxwIJkhybUu4ExTZn3frtNTSGn+dA6fkd9K3/tDVn9TP9Nnm9P
         VPTnYxdzdlXInK6kr19c9qSIhHW9qnL6jHKkn84+GOchG2f0R6AedgV5+3uf72qEiPr3
         zbow==
X-Received: by 10.60.150.146 with SMTP id ui18mr11309616oeb.101.1369395787180;
 Fri, 24 May 2013 04:43:07 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Fri, 24 May 2013 04:42:37 -0700 (PDT)
In-Reply-To: <519F4684.7010905@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225348>

On Fri, May 24, 2013 at 5:52 PM, "=C3=81kos, Tajti" <akos.tajti@intland=
=2Ecom> wrote:
> Dear List,
>
> I created a dump from a repository. git bundle list-heads prints all =
the
> refs I meant to add. The problem is that after exracting the dump wit=
h git
> bundle unbundle the target repository doesn't contain any branches (g=
it
> branch -a prints nothing). How can we exract a dump so that the branc=
hes are
> also restored?

I think "git fetch /path/to/the/bundle <refspec>" does that.
--
Duy
