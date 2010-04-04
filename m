From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Tests with broken && chains in pu
Date: Sun, 4 Apr 2010 22:41:17 +0200
Message-ID: <201004042241.17655.j6t@kdbg.org>
References: <201004042208.58939.j6t@kdbg.org> <v2yfabb9a1e1004041315x999376f6m7dd689b529ce33d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 22:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyWfP-0000cu-TC
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 22:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0DDUnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 16:43:32 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:37174 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751580Ab0DDUna (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 16:43:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2B7E8A7EB0;
	Sun,  4 Apr 2010 22:43:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BC96D19F5E9;
	Sun,  4 Apr 2010 22:41:17 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <v2yfabb9a1e1004041315x999376f6m7dd689b529ce33d8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143945>

On Sonntag, 4. April 2010, Sverre Rabbelier wrote:
> Thanks for noticing, may I ask how you noticed? Do you have a script
> or was it manual review?

It was manual review. I reviewed the patches in pu because I noticed a broken 
&& chain in a recently submitted patch, but I didn't remember which one it 
was. So I took the time to look at all new test cases in pu after Junio's 
recent What's in git message.

-- Hannes
