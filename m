From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] Record original ref in detached HEAD
Date: Tue, 26 Feb 2013 21:57:36 +0700
Message-ID: <CACsJy8BJqoCVHm=jY+Y6LB_aKuyE5HsGA=eHmYur-Lfrp+PE4A@mail.gmail.com>
References: <1361888897-1821-1-git-send-email-pclouds@gmail.com> <vpqsj4jqgy4.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 15:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UALzF-0007KR-RI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 15:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759361Ab3BZO6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2013 09:58:08 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:42273 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233Ab3BZO6H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2013 09:58:07 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so5337425oag.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 06:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=LtzWkaBNnlKByBjghmeYhCYJCqpcGqlvqrpKxyF8szE=;
        b=bHCQpWgwY8rBxbOhM0yo1TxR2wRby+rbgfzqU+5xgmj80IFpVG2JSHnbtwjZ0WB22C
         cPlw2+WIaIIxqxvp9CXByDNoKlyoZpuU4yrr9dyL6EZnGI4AGJ6it2fAuOQCCassy9gx
         Dqq8zyW/5wcDgDFLM7SiOB2GmzNBfA5TBWB9RLZETkuLQM1eK1ccwWRIFZbP8unLOQ7f
         XnrJEpYLmaVQPTn9Gz8br0wH3XNvReQXlI7bveuI2tWxWiztqyI81i7Edmzpf3sAWWmz
         pojbNFeJI1t4Y0WtVtZ8nHmJ/0lavFp/WaJGAWvWZouS063XzZK+8XfOu7sAzy0UrYGf
         4MKQ==
X-Received: by 10.60.6.199 with SMTP id d7mr1572921oea.137.1361890686675; Tue,
 26 Feb 2013 06:58:06 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Tue, 26 Feb 2013 06:57:36 -0800 (PST)
In-Reply-To: <vpqsj4jqgy4.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217135>

On Tue, Feb 26, 2013 at 9:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Many times I checkout a remote branch, or a tag and after a while I
>> forget remember what ref I checked it out from. Saving the original
>> ref would help (or is it already saved somewhere?).
>
> It is :-). Try e.g.
>
>   git checkout --detach
>   git checkout -
>
> (analogous to "cd -": return back to where you were before)

Yeah. I always manage to forget reflog when I need it. Time to show
the information in "git branch", oh wait I still have a wip about
git-branch on pu..
--=20
Duy
