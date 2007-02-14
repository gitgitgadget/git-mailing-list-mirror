From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really altering the ref
Date: Wed, 14 Feb 2007 09:13:53 +0000
Message-ID: <200702140913.55506.andyparkins@gmail.com>
References: <200702131512.45412.andyparkins@gmail.com> <7v4pppuwpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 10:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHGDH-0007gn-4O
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 10:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbXBNJOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 04:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXBNJOD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 04:14:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:56536 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbXBNJOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 04:14:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so116644uga
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 01:13:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TXstXlN7G+cN0BO+o/MVtx3BqbLM3bgPTt4ZmLMYfk54nQG8OySRcs2gyzDyLfTTdXN/RIvrPFi0YrRrhPYgiEl4kznUDhRzyhkFV+3YypyxopbMvePNgsSU3fP7JV9k5yGiA3xUj8MLEVshKZnhz5dtohB5jSBfdpagB2TwA9I=
Received: by 10.82.135.13 with SMTP id i13mr267418bud.1171444439553;
        Wed, 14 Feb 2007 01:13:59 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 50sm452374ugb.2007.02.14.01.13.57;
        Wed, 14 Feb 2007 01:13:57 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7v4pppuwpv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39626>

On Wednesday 2007 February 14 05:36, Junio C Hamano wrote:

> Everybody else seems to say 'print "error 1 blah blah"'.  Are
> you sure "error 2 message" is Kosher protocol-wise?

Oops.  No I'm not sure at all.  I hadn't noticed that was a protocol command; 
I'd read it as being output to stderr which appears to be just commentary to 
the CVS client.  I assume you don't want a patch just to correct that?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
