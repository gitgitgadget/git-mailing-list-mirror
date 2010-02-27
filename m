From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Retrospectively add alternates to a repository?
Date: Sat, 27 Feb 2010 10:37:25 +0800
Message-ID: <be6fef0d1002261837g794e8df2yc92261d46f3235bd@mail.gmail.com>
References: <loom.20100227T004822-959@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steve Folly <steve@spfweb.co.uk>
X-From: git-owner@vger.kernel.org Sat Feb 27 03:37:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlCYo-000485-4W
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 03:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759551Ab0B0Ch1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 21:37:27 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:60010 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759532Ab0B0Ch0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 21:37:26 -0500
Received: by iwn12 with SMTP id 12so787118iwn.21
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 18:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rkls0MLxoZ1hIadkv1ZZT8p3RnsMmlYfDhmIF3Z1nFA=;
        b=qBsvbT0QaG8xmLGxS8W0N5aKR94PlZDVcFnRaRRCWUcQccLchDqo1fq/R9Lo3Tj1/+
         OrD0mJv9VKUd5sUentJRvBfEpyui35gZsUPz/BTdeHNkSgNZERMT1/lCtY1eHbngEsTj
         iIZ4QW9KOGZNjUJ4C5vUb1Z7RdFz48VC8GlPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ATQtAPA/4jm9SaPfwfkhQjhx3vd0FclIPbbczQmNlzYdLzyM8/VirGDiiP3F6rco+l
         2KSLz4OGptUBHA8qqubAOP2CHbai8TzVoN3qdctW8W9e66YYugVSwtHOrD/toKPkOLr0
         Ml7FScERFbjOi9Q4bzNcoQYlMNve+HGls3nFc=
Received: by 10.231.168.133 with SMTP id u5mr347831iby.29.1267238245545; Fri, 
	26 Feb 2010 18:37:25 -0800 (PST)
In-Reply-To: <loom.20100227T004822-959@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141165>

Hi,

On Sat, Feb 27, 2010 at 7:54 AM, Steve Folly <steve@spfweb.co.uk> wrote=
:
> I have a local mirror of a remote repository (to save time
> cloning over a slow network). =A0But before I created the
> local mirror I already cloned the remote repo directly.
>
> Is it possible to retrospectively add an alternates spec
> to this local repository (the equivalent of doing what
> --reference does during the clone)?

yes, just make sure the objects/info/alternates file points to the
location of that cloned repo's object directory; for example:

  $ echo /path/to/cloned/repo/.git/objects > .git/objects/info/alternat=
es

--=20
Cheers,
Ray Chuan
