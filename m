From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Thu, 28 Feb 2008 13:57:08 +0100
Message-ID: <47C6AFA4.9040304@gnu.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 28 13:57:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUiKe-0007d1-5U
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbYB1M5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 07:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYB1M5Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:57:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:60135 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbYB1M5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:57:15 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1863559nfb.21
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 04:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=E5R1rJBJDVSdVRaveGq5MC3v7RBHtoXUJ/0mgzsyV9c=;
        b=tJVyu+2IqLY98E0O7UF5wo1wzz5hq4BucDsFJc6AZjrXwsQnNya0MEjGBy/nt12RNtn/ez7CJh4kBZHQLcNxu5542LxdTeoT1khgSCE5GeX7VZ9ciVhh+Xh7/l5XrSghTUhHzZm3mEov0eksANoWiG5VDe4wv3FAltbcwat645Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=WnPaOYTTXK7q9XGSxqCQjKmXP4+VuWc3HdagnsxUXzSVM2P96I38qSnFVHXWpbJVQlSPbnZ/iN7DXakdjutsJ53cCMgnhHFbGphgl2UPkaf3g+pjPSEW9IPWUSHg+tnD1WyYwAYY47HwIqLU8bMEps5z7Pgfum2UQJn5KkRTARI=
Received: by 10.82.112.3 with SMTP id k3mr4780307buc.6.1204203431581;
        Thu, 28 Feb 2008 04:57:11 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id e10sm4573511muf.10.2008.02.28.04.57.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Feb 2008 04:57:10 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.LSU.1.00.0802281159550.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75395>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> 
>> +int gettimeofday(struct timeval *tv, void *tz)
>> +{
>> +	return 0;
>> +}
> 
> Should it not return -1, for failure?  (I know, I know, probably a few 
> programs do not work, then, but it is not correct that it succeeded.)

FWIW, this is overwritten by later patches in the series anyway.

All the other suggestions that Dscho wrote about, make a lot of sense to 
me too.

Paolo
