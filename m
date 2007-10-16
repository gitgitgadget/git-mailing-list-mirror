From: Andreas Ericsson <ae@op5.se>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 19:20:10 +0200
Message-ID: <4714F2CA.5000509@op5.se>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <20071016070421.GE13801@spearce.org> <11F85069-1013-4685-9D56-C53F0F8231BF@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihq6C-0003zS-D6
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761329AbXJPRUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760757AbXJPRUQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:20:16 -0400
Received: from mail.op5.se ([193.201.96.20]:33029 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761267AbXJPRUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:20:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C58B71730722;
	Tue, 16 Oct 2007 19:19:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LfX07QIb4UbO; Tue, 16 Oct 2007 19:19:45 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 232C217306FD;
	Tue, 16 Oct 2007 19:19:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <11F85069-1013-4685-9D56-C53F0F8231BF@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61226>

Michael Witten wrote:
> On 16 Oct 2007, at 3:04:21 AM, Shawn O. Pearce wrote:
> 
>> The C code is all tabs, with the tabs set at 8 spaces, but the
>> actual tab width isn't too important here as we never use the tab
>> for alignment beyond the left indent.
> 
> Consider this from diff-lib.c:
> 
>> /* A file entry went away or appeared */
>> static void diff_index_show_file(struct rev_info *revs,
>>                  const char *prefix,
>>                  struct cache_entry *ce,
>>                  unsigned char *sha1, unsigned int mode)
>> {
>>     diff_addremove(&revs->diffopt, prefix[0], ntohl(mode),
>>                sha1, ce->name, NULL);
>> }
> 
> There are mixed tabs and spaces for alignment.
> 

Function declarations don't count ;-)

> I suppose I'll be fine if I just set tab widths to 8.
> But 8 spaces! Good Lord. ;-)
> 
> I really hate tabs.
> 

Well, using hard tabs is the only way we can let everyone have
different levels of indentation while still having things look
sort of sane.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
