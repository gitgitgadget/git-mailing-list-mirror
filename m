From: Andreas Ericsson <ae@op5.se>
Subject: Re: Python extension commands in git - request for policy change
Date: Mon, 26 Nov 2012 12:05:44 +0100
Message-ID: <50B34D08.8000208@op5.se>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com> <20121125095356.GA22279@thyrsus.com> <CAMP44s1oRpm4QkhcbfAuxK8UTZnuSVfNhAQnmUd1xiwhwLEqGw@mail.gmail.com> <20121125173229.GA32394@thyrsus.com> <CAMP44s2ft7vvaGqHUa2CytpAsX8vOF3YQo24PLPsD6y1Dk3GZQ@mail.gmail.com> <20121125224443.GC6937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Nov 26 12:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcwVp-0000Xh-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 12:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab2KZLFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 06:05:50 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59662 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab2KZLFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 06:05:49 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4386589eek.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 03:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=+6rx6zyVdEIbx4TCGopES4hg643x5v+2HsR05oKR+LU=;
        b=mqimSyMTj9VlI4up/x/385s6Enz5Ps6atI9cdU3QjKBOw9sBttkYpTWhGbAyoZ+Erp
         y9BZGULoulAg6xJKjPxCuIEZcHHOUcol71uUZI7a6p/rtsUWMC6190kPsnFipqOterlX
         p5nvC2wptZwrGxNToKYILOvvrkQMZ+MoRIRXzX/x1X7vasVPOV6SwC9hR6xK+I2wZjmG
         +m9TOoFyaGU1GAaEzG3mJPODlJR1qa7EfWiexzb0ycJ4bJd6coda+dhE/Jku/Dy4UAod
         XNoQ7nWzabQJ9vT7AmzcQ0dVT2mThYle6C0+BQ4SB7MVV4rnpQ0vFAiT590LYo8XqvdQ
         5d+Q==
Received: by 10.14.216.70 with SMTP id f46mr44564875eep.12.1353927948196;
        Mon, 26 Nov 2012 03:05:48 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id q2sm33482491eem.13.2012.11.26.03.05.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Nov 2012 03:05:46 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <20121125224443.GC6937@thyrsus.com>
X-Gm-Message-State: ALoCoQljMnwVnI/cevgC5r+6t7LxrDvL8FT7QJNfLjEyMrzk3nG3FZ7SrJ16JcieyW0RSqMCxdn0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210429>

On 11/25/2012 11:44 PM, Eric S. Raymond wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> According to the results of the last survey, our users do care about
>> performance, so I don't think there's anything excessive about it. Are
>> there any hidden costs in maintenance problems? I don't think so.
> 
> Then you're either pretending or very naive. Three decades of
> experience as a C programmer tells me that C code at any volume is a
> *serious* maintainance problem relative to almost any language with
> GC.  Prudent architects confine it is much as possible.
> 

Prudent architects also avoid rewrites as much as possible, since it's
inevitable that bugs will be introduced that have been fixed in the
"official" version.

Personally, I think if you'd left your suggestion on "It would be great
to have guidelines for python scripts. I propose 2.6 as the minimum
required python verison" and left it at that, there would have been
very little disagreement. The suggestion that things should be rewritten
in python for some spurious long-term savings seems mostly designed to
refuel everyone's favourite flamethrower, and you know as well as I do
that it just won't happen unless there's at least a chance of some
substantial technical benefits from doing so.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
