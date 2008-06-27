From: Christian Holtje <docwhat@gmail.com>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Fri, 27 Jun 2008 09:44:39 -0400
Message-ID: <8F75DDC9-AECF-4158-B2DC-9B038936B560@gmail.com>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org> <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com> <20080627025413.GA19568@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: logank@sent.com, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCEGi-0004xr-3c
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbYF0Non (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbYF0Non
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:44:43 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:58046 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbYF0Non (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:44:43 -0400
Received: by py-out-1112.google.com with SMTP id p76so115923pyb.10
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=6NkNRmBY1a/RhGaUpbXTGVX6kbbVjhouK9Mk6sQSGXA=;
        b=ws8ShZq4c75vGa2NuXbCdH9OkRU4PFsYZAzPvA+PUI3LYMPcbF1CHkO6pMGnmuajw/
         hp40QUKbSh0HQNHiwOukFJUoN6wh0TV+Lpx6NRSWd7yRhGYtNfxiAFnUWzkvB5KQU2C6
         NvyEzVD3rhPkIJSq0ic61vKyF3bi5iXl3JIss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=UykATQpiG9tlCDNFjy/51sH0X81A757OdOFot415pfOxmigBM4Eq4PkrQY66lOMTN9
         5m6zKXBgOmgNzhyqXeN4FqXv9Jq4+J7CAbi2TLq1jUdAQsT1Nzy39ePdMkIgP1zpyCM2
         /FcnXrvhT7s8ivZyMN00iVXGOQ2OjWOBaqL60=
Received: by 10.114.75.1 with SMTP id x1mr1397846waa.25.1214574281906;
        Fri, 27 Jun 2008 06:44:41 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id 6sm1091291yxg.6.2008.06.27.06.44.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 06:44:41 -0700 (PDT)
In-Reply-To: <20080627025413.GA19568@fieldses.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86561>

On Jun 26, 2008, at 10:54 PM, J. Bruce Fields wrote:
> On Thu, Jun 26, 2008 at 04:36:27PM -0700, logank@sent.com wrote:
>> No, it seems to be a simple error-out in this case. We have 2.4.20
>> systems
>
> That version's for the client or the server?

For the bug I sent the information is:
Server:
Linux dev1 2.4.28 #3 SMP Tue Jan 18 14:59:40 EST 2005 i686 i686 i386  
GNU/Linux
Red Hat Linux release 9 (Shrike)

Client:
Linux dev2 2.6.9-42.0.8.ELsmp #1 SMP Tue Jan 30 12:18:01 EST 2007  
x86_64 x86_64 x86_64 GNU/Linux
CentOS release 4.4 (Final)

Ciao!
