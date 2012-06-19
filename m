From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 18:17:27 +0200
Message-ID: <CAGK7Mr41h3k=6S6HizAbL_n1Ma8KJkYQuqE6w1=G7DeNrbtLwQ@mail.gmail.com>
References: <4FE091FB.7020202@desrt.ca> <4FE09C39.50702@elegosoft.com> <4FE0A0C0.2080409@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Jun 19 18:18:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh180-0004yx-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 18:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415Ab2FSQR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 12:17:59 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:43050 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab2FSQR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 12:17:59 -0400
Received: by ghrr11 with SMTP id r11so4785183ghr.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UKZheLQlBbnNxwZb3NnOUL/6zTWgVZe4pkg8R2Ab1N8=;
        b=pRqPF155JztoJmn2WHFIFm3H9zIAgNt48XX7UmHDWHoO+1tswep4tHMVYaonAGQ3xm
         CF1uV5Y++D3iwzH1KzUD12GVvBrcieh4DMwKWU8DhYuXqedLWn8NbvozYWyGDKteDSlo
         9LiRbVrCVTFRlVsg8FpK1Y+75d35MC3qECHpdtsyeQOkwHkNhmYk2tflxp7mriVbA/Yj
         heZuTTmJfVEZN5T8eQX/+vh8RgHyY6UGbEl34IHJeeAtCDDNPvxx92YsER2t7qIvXCFo
         69WHq1AsQIDfl6rOpwmkWd7t7mfoqnLEHpEt4mbplpD75fzDjOu8fjx2GNYsDAP4d6tl
         dTxg==
Received: by 10.50.183.228 with SMTP id ep4mr1822240igc.74.1340122678018; Tue,
 19 Jun 2012 09:17:58 -0700 (PDT)
Received: by 10.50.99.10 with HTTP; Tue, 19 Jun 2012 09:17:27 -0700 (PDT)
In-Reply-To: <4FE0A0C0.2080409@desrt.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200211>

>> This very much violates the distributed nature of Git. Everything
>> is allowed, because it's *my* repository.
>
>
> It is certainly allowed, as originally mentioned, with a --force option of some kind.
>
> It is only prevented by default because it is likely you are making a mistake...


I second that, way more often than not it *is* a mistake to create a
branch with the same name as one in a remote. In the unlikely scenario
where it is what you want, I think asking for a -f/--force is not too
much.

I think the feature request is in sync with "git branch -d" refusing
to delete an unmerged branch because it's unlikely that it's what you
want, and forces you to use -D instead.

Philippe
