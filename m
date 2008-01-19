From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Sat, 19 Jan 2008 17:04:31 +0100
Message-ID: <47921F8F.9020401@gnu.org>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org> <alpine.LSU.1.00.0801191119050.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 17:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGGBq-0003yG-Ae
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 17:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759156AbYASQEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 11:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757655AbYASQEd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 11:04:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:30019 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbYASQEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 11:04:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1349851fga.17
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=TIv5VGzs/bGMeBNXKjkBMzRC3v4Axm2oyQkpiDlEuyY=;
        b=JZS8ygffrNidOzsXv0+kyZXDxPufYMP4dHrIkiiprodrMB2ZYEM46Y9iggZea0izLY3ph0EVZwOQs9fTeZSuiH643x+sMLEEVfqI9VJEHuWc39Poz6CyMl0ci3hyUTC1xn/yljKvDQ1qSlIfJxIlZNTAj49tZBxGjYaV0fLn9/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=o0JFN15JshL4+bLWt9s/+/Ci3EWUhh3/j6SnIgR/WnzxNTxC09lJO9o4b8Y7ZZeR79QAbjRDTTz7H9eFgrf/Yix+StV+UrAAN1MG/uKMnN8wV/O0K5CJOIsKd8c8fu+PTJsQt9u2t1QtHshEnSdJFVAAkEtHHxo7ZJpTBMKnzFo=
Received: by 10.86.30.9 with SMTP id d9mr4344393fgd.52.1200758670624;
        Sat, 19 Jan 2008 08:04:30 -0800 (PST)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l19sm7985838fgb.9.2008.01.19.08.04.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Jan 2008 08:04:30 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0801191119050.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71121>


> Of course, there is a fourth of "two other" possibilities:

(The third was just the previously posted patch, so two "other than the 
posted one") :-)

> Make a script calling git-commit with "-F - -e" and pipe your generated 
> template into it.

You considered that this script should parse -a, -i, -o, whatever, 
right? ;-)

The point is that a hook can use the index as prepared by git-commit.

Paolo
