From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: fast-import should not care about core.ignorecase
Date: Mon, 08 Dec 2014 20:20:52 -0700
Message-ID: <54866A94.2040305@workspacewhiz.com>
References: <20141209001211.GA13386@glandium.org> <54864B3D.6040503@workspacewhiz.com> <20141209013138.GU16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 04:20:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyBM2-00019F-O6
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 04:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbaLIDUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 22:20:47 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:44006 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430AbaLIDUq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 22:20:46 -0500
Received: (qmail 3409 invoked by uid 399); 8 Dec 2014 20:20:48 -0700
Received: from unknown (HELO ?192.168.1.184?) (jjensen@workspacewhiz.com@207.225.223.75)
  by hsmail.qwknetllc.com with ESMTPAM; 8 Dec 2014 20:20:48 -0700
X-Originating-IP: 207.225.223.75
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141209013138.GU16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261105>

Jonathan Nieder wrote on 12/8/2014 6:31 PM:
> Joshua Jensen wrote:
>> I think it has been discussed before, but maybe Git needs a
>> core.casefold in addition to core.ignorecase.)
> Would it work for --casefold to be a commandline flag to fast-import,
> instead of a global option affecting multiple Git commands?
Given that core.ignorecase=true means to fold filename case in quite a 
number of places within Git right now, I would expect the same behavior 
within a repository where fast-import is being run against 
core.ignorecase=true.

So, I don't know what core.ignorecase should mean, but I'm pretty sure I 
know what core.foldcase should mean.

Would --casefold work?  Sure, but it would be a special case against the 
existing core.ignorecase behavior that I don't think makes much sense.

Josh
