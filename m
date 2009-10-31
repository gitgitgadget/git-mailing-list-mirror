From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 10/19] Allow helpers to request marks for fast-import
Date: Sat, 31 Oct 2009 17:19:32 +0100
Message-ID: <fabb9a1e0910310919l2e81bf43uc5adaec845e26b4e@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<200910300921.00561.johan@herland.net> <fabb9a1e0910300526v5cbcf685l69f60c58b7e3732@mail.gmail.com> 
	<200910311304.05408.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 31 17:21:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Ght-0007BE-GT
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 17:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757855AbZJaQV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 12:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757847AbZJaQV0
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 12:21:26 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:32835 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbZJaQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 12:21:25 -0400
Received: by ewy28 with SMTP id 28so3784602ewy.18
        for <git@vger.kernel.org>; Sat, 31 Oct 2009 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=XEscmqjRY067eNMZqCqaHoVaMaZ+AhCCIg7Ih+Uw0pQ=;
        b=cCgK/vH9GVUDHcbR5ILCawu8x0RF1adb8lsNyrzhFjAGQUcg4dh8PrUSZSGFKBPJ7o
         BWJtv9t/FBUNtsUObgb6abNy+SW6wj3i196WtnorSAEIS9N1N9lYDfVCKQnHhueqLvy7
         /Uv0CrjsK8g3K09mtNGoLvmX5avtpkJmVCMrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Y5O2J7+JhsvEq7hMkuEa/B0Zzc31aRmro87GbZeNx7L99XKbSURPRycMxAaFahVujL
         U3QQG/pNr80c+MYl8nkGZle/kq1KpVvxWxukisnvt5V+W08lb56LiR/m06d2khUWJcWF
         jjAoNjs4ymiWtEvdJaSUeavwzTmVl/YIjvw0E=
Received: by 10.216.89.193 with SMTP id c43mr1875183wef.221.1257006089645; 
	Sat, 31 Oct 2009 09:21:29 -0700 (PDT)
In-Reply-To: <200910311304.05408.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131845>

Heya,

On Sat, Oct 31, 2009 at 13:04, Johan Herland <johan@herland.net> wrote:
> On Friday 30 October 2009, Sverre Rabbelier wrote:
> This conglomeration of patch series is becoming fairly complicated, and it's
> becoming hard to stay in sync. I suggest that you drop the CVS-specific
> parts from this series, and work on stabilizing the common infrastructure.
> Once that has settled, you can send a git-remote-hg series, and I can send a
> rebased and updated git-remote-cvs series.

That sounds like a good idea; I want to use the marks in git-remote-hg as well.

> Feel free to reorganize the patches so that the git_remote_helpers
> infrastructure is created in the correct location (instead of reorganizing
> git_remote_cvs).

Ok, will do.

-- 
Cheers,

Sverre Rabbelier
