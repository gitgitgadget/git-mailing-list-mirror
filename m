From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [RFC/PATCH] git-gui: Use gitattribute "encoding" for file content display
Date: Wed, 23 Jan 2008 07:02:27 +0000
Message-ID: <7E519595-ED6F-454C-9F2A-3011F1E94A50@simplicidade.org>
References: <20080123054709.GA13166@spearce.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Michele Ballabio <barra_cuda@katamail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 08:03:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHZdY-0003Yq-Vu
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 08:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbYAWHCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 02:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbYAWHCe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 02:02:34 -0500
Received: from mail.sl.pt ([212.55.140.13]:35270 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753307AbYAWHCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 02:02:33 -0500
Received: (qmail 10430 invoked from network); 23 Jan 2008 07:02:30 -0000
X-Virus-Status: Clean (0.03086 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.06395 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[82.154.15.121])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 23 Jan 2008 07:02:30 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 82.154.15.121 as permitted sender)
In-Reply-To: <20080123054709.GA13166@spearce.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71515>

Hi,

On Jan 23, 2008, at 5:47 AM, Shawn O. Pearce wrote:

> I've got the following change in my "pu" right now and am considering
> adding it to git-gui 0.9.2, which would be in git 1.5.4.
>
> I've CC'd a number of people who have emailed me in the past
> about git-gui's diff or blame failing to display a non US-ASCII
> file content correctly and I am interested to hear if this would
> resolve the issue for you.  Its configurable on a per-path basis
> by an "encoding" attribute in .gitattributes (see git-gui's own
> example below).

This solves the problem for me.

The diff display correctly display utf-8 characters.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
