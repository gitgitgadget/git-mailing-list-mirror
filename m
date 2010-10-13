From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Documentation for git gui blame
Date: Tue, 12 Oct 2010 20:32:18 -0600
Message-ID: <4CB51A32.1040304@workspacewhiz.com>
References: <4CB48909.6050708@workspacewhiz.com> <4CB48C5F.2030007@gmail.com> <m3iq176vh2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 04:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5r8k-0006oa-3y
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 04:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab0JMCcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 22:32:20 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:50613 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0JMCcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 22:32:20 -0400
Received: (qmail 32380 invoked by uid 399); 12 Oct 2010 20:32:19 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 12 Oct 2010 20:32:19 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <m3iq176vh2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158905>

  ----- Original Message -----
From: Jakub Narebski
Date: 10/12/2010 1:50 PM
> Chris Packham<judge.packham@gmail.com>  writes:
>
>> On 12/10/10 09:12, Joshua Jensen wrote:
>>>   Is there any documentation for git gui blame that explains what the two left columns containing 4 letter SHAs are?
>> These are the first 4 characters of the commit id that last
>> added/changed that line of code.
> Note that there are *two* columns because one column contains plain blame,
> and second contains blame with code movement and copying detection and
> discarding changes in whitespace (like "git blame -C -C -w").  So if those
> columns are different, one column would show commit that put code here,
> and the other would show commit that changed this code.
Ah, great!  That's what the other column is all about!

Thanks, Chris, for the Blame Parent Commit info, too.

Josh
