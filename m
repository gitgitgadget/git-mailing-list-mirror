From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Thu, 9 Aug 2007 09:22:44 +0100
Message-ID: <18071eea0708090122h79dec205j4528f4dfd7aab588@mail.gmail.com>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
	 <1185851481271-git-send-email-eclesh@ucla.edu>
	 <20070731040510.GD12918@filer.fsl.cs.sunysb.edu>
	 <87bqdhnotj.fsf@hubert.paunchy.net> <86r6mdp1e1.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3IL-0002Ns-7E
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 10:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbXHIIWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 04:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbXHIIWs
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 04:22:48 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:63017 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765827AbXHIIWq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 04:22:46 -0400
Received: by py-out-1112.google.com with SMTP id d32so691068pye
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 01:22:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MRaiOCjL+9XEEp7M21PVf+nz1ZZYm5TtIBy8wwWoc3+vY8sDPl6ahuhfEzcDArnD1QtviY2sK+Ab4dQdvyXcLdJczX9nP+YTSEFs6d5jH5rtB0x6KEFDMZtylVse2F+HHT82Q1A/CSuBFDz9KzY4np1ndMCICL8xauPYHLkrVfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f2ERADEP6WWlpCqQXjJnuT2fk2rZVM6HwznvgKTf/XWAAB1Tz3vIMCpkQV0VUbduYw+xveZrkURPd/0P3vWQE7SKnu3SlbZhsx0zULaFdnlOScGwivE8FHtJoWFoZwV1UzX4PW1gWOLbyVIQM3nEKfAyX6d0+mY/O+vKEHnIF0g=
Received: by 10.142.214.5 with SMTP id m5mr456170wfg.1186647764663;
        Thu, 09 Aug 2007 01:22:44 -0700 (PDT)
Received: by 10.142.82.18 with HTTP; Thu, 9 Aug 2007 01:22:44 -0700 (PDT)
In-Reply-To: <86r6mdp1e1.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55426>

On 09/08/07, David Kastrup <dak@gnu.org> wrote:
>     sed -i -e "s,^\($p[[:space:]]*.*\)\$,\1 #$x," "$series"
>
> and that's fine.

I'm surprised to see 'sed -i' being at all, it's certainly non-portable.

-- Thomas Adam
