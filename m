From: "Philip Oakley" <philipoakley@iee.org>
Subject: How to use --cc-cmd in git-send-email?
Date: Sun, 19 Jul 2015 23:02:39 +0100
Organization: OPDS
Message-ID: <CA64425B296E41328D6A1F29E227A24D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 00:02:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGwes-0002Pz-MX
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 00:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbbGSWCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 18:02:01 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:53326 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754068AbbGSWCA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2015 18:02:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C3VgBvHaxVPN4GFlxcgxIBAYEHhwZtthaFfAQEgSBNAQEBAQEBBwEBAQFAASQbhB4UAQEuHgEBLAIIAgEkOQEEGgYHAxobAgECAwGIIZ52h1OOY48Tj28RAYNvgRQFjHCHYgGBCqQdgW8BAQgBAQEBAYIlPYE+gT4BAQE
X-IPAS-Result: A2C3VgBvHaxVPN4GFlxcgxIBAYEHhwZtthaFfAQEgSBNAQEBAQEBBwEBAQFAASQbhB4UAQEuHgEBLAIIAgEkOQEEGgYHAxobAgECAwGIIZ52h1OOY48Tj28RAYNvgRQFjHCHYgGBCqQdgW8BAQgBAQEBAYIlPYE+gT4BAQE
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="614446415"
Received: from host-92-22-6-222.as13285.net (HELO PhilipOakley) ([92.22.6.222])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 19 Jul 2015 23:01:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274297>

I've been using git-send-email with repeated individual --cc="email 
address" parameters on the command line.

I tried putting all the addresses, one per line, into a file 'cc-cmd', 
so I could use if for the --cc-cmd option.

I then tried to use --cc-cmd='cat cc-cmd' to do the send-email (as 
a --dry-run). This produced, as part of the output, a list of the output 
of the cc-cmd, which showed not only the file contents, but this was 
then followed by the full patch, as if it was part of the list of email 
addresses.

Finally, at the end of the inclusion of the patch, I got

(cc-cmd) Adding cc: -- from: 'cat cc-cmd'
(cc-cmd) Adding cc: 2.4.2.windows.1.5.gd32afb6 from: 'cat cc-cmd'
(cc-cmd) Adding cc:  from: 'cat cc-cmd'
error: unable to extract a valid address from:
What to do with this address? ([q]uit|[d]rop|[e]dit):

Could this have been caused by an extra (blank) line at the end of the 
cc-cmd file?

Also, does anyone have an example of a working --cc-cmd option?

(this is on g4w: git version 2.3.1)

Philip 
