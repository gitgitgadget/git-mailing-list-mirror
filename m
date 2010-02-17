From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 21:39:40 +0800
Message-ID: <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
References: <201002171627.57599.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
X-From: git-owner@vger.kernel.org Wed Feb 17 14:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhkGo-0000ux-0V
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 14:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934205Ab0BQNsD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 08:48:03 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:61708 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934288Ab0BQNr6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 08:47:58 -0500
Received: by pzk17 with SMTP id 17so6302198pzk.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 05:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ubb5EbYTUYp4JbTc+N+z9KaoMFWLbjs+0kpC2pffM8c=;
        b=cEUQKb/N5HB9ERVkSX6y0EzmCiz58HzLZ52FMM7rkjsAfumGGtY9gHJNgz53/Obdo/
         nOd5Z0R5IPl7PLPpU+WvOBYlDO++SjoC4BIBIM6lrj45cNGXKooLLTW1/0Om23KWVMbf
         lj7CPEGbh0nvNBk6MuI82/QvvpaEiqgbu/9fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vB/llauE37Tb7Fbc4zMq0TqkFo9G+s4CKE1pxO50mnz0eIUOSAYLJkR6/K9wP00//l
         L/G6oboO1yFC4kOXUaex7i4pFzjJ/1lnKwf4+tmdpy9QaYJDEIY+qNCar51omqO5zqqS
         fxFi4qO/G90v/uoM55SrP5c1lC/JuyzK+UjaE=
Received: by 10.142.59.20 with SMTP id h20mr4711261wfa.44.1266413981003; Wed, 
	17 Feb 2010 05:39:41 -0800 (PST)
In-Reply-To: <201002171627.57599.arvidjaar@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140235>

Hi,

On Wed, Feb 17, 2010 at 9:27 PM, Andrey Borzenkov <arvidjaar@mail.ru> w=
rote:
> {pts/1}% l .git/refs/heads
> local-mdv =A0local-mdv.stgit

have you tried

 $ cat .git/packed-refs

?

--=20
Cheers,
Ray Chuan
