From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 10:44:15 -0400
Message-ID: <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
	 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
	 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
	 <alpine.DEB.1.00.0805171102480.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 17 16:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxNel-0000Sl-PI
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 16:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbYEQOoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 10:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYEQOoR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 10:44:17 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:25940 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbYEQOoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 10:44:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so297731and.103
        for <git@vger.kernel.org>; Sat, 17 May 2008 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6pJvr3CHnIA1hLXHm0TnLMQALaH4gsGrVwfr9dU//Fw=;
        b=SX7pz643W5FwMaXiSToiJO2YX/mkT/tanOpeg3zw+7L7e4GG8zAP6Pz6DzL7ak919gMOr+WHq34XTdCTWb8gfSJsGp/A3bL6aF5dX/eRMbUfUUBL2ycxdqmZL9ViZHUTX9GboG1L+7O6Zq0GVwQDwQpMeOJzzVKKOiH+huj5AVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vzJESyOymM91QIeMwlJUPee9gxLGOs8N42YmuOd1MK3+rhB/z+XKoZ6cJKNN3VcL/koVNSs+vdDQyVQlzInA5TIDS232g8Bz5sTtM26eWC0N9r7HmalcacqZmPayzOuBJovQ2k5PS8XPZqe73PHxp+oCWwK2xoU9m8JQgttCmio=
Received: by 10.100.229.12 with SMTP id b12mr6043857anh.60.1211035455852;
        Sat, 17 May 2008 07:44:15 -0700 (PDT)
Received: by 10.100.92.6 with HTTP; Sat, 17 May 2008 07:44:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805171102480.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82348>

On Sat, May 17, 2008 at 6:04 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Is this user interface set on stone? I think we should reserve the right
>> to improve always.
>
> Umm.
>
> As has been mentioned, this is not a "user interface".  The message you
> are seeing comes from a _plumbing_ program, i.e. something _not_ meant for
> human consumption.
>
> I still think that it might be better to add a command line option with a
> custom message, because that would _not_ break backwards-compatibility.

With this dedication to backwards-compatibility, we'll be at Windows
Vista quality in no time.
-- 
-Steven Walter <stevenrwalter@gmail.com>
