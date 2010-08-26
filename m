From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 12:25:10 -0600
Message-ID: <4C76B186.5080809@workspacewhiz.com>
References: <4C7681F1.3070205@workspacewhiz.com> <7vy6btl2yo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 20:25:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ooh8i-0004Z2-5i
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 20:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab0HZSZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 14:25:24 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:47687 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0HZSZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 14:25:12 -0400
Received: (qmail 614 invoked by uid 399); 26 Aug 2010 12:25:11 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.39.54)
  by hsmail.qwknetllc.com with ESMTPAM; 26 Aug 2010 12:25:11 -0600
X-Originating-IP: 75.220.39.54
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <7vy6btl2yo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154552>

  ----- Original Message -----
From: Junio C Hamano
Date: 8/26/2010 11:05 AM
> Joshua Jensen<jjensen@workspacewhiz.com>  writes:
>> I tried manually moving .git/refs/notes/p4notes to .git/p4/p4notes.
> Bad idea.  Your notes no longer are protected from fsck and prune.
>
> Don't do it.
And had I thought for longer than 1 minute about it, I would have 
realized that.

Okay then...

gitk --all --not --glob=refs/notes/*

does not work.  Is there a way to make it work?  I think, from another 
conversation asking a different (but related) question, the answer is no.

Josh
