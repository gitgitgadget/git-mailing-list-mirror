From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 1/8] Docs: send-email's usage text and man page mention same options
Date: Sun, 28 Sep 2008 14:04:30 -0500
Message-ID: <55747712-8E21-45F0-B2D2-4B4856568592@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <20080928050828.GZ23137@genesis.frugalware.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 21:06:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk1ax-00067a-2z
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 21:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYI1TFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 15:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbYI1TFD
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 15:05:03 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:38036 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752339AbYI1TFB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Sep 2008 15:05:01 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8SJ4WFi027115;
	Sun, 28 Sep 2008 15:04:32 -0400 (EDT)
Received: from [192.168.0.65] (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8SJ3K6E015113
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 28 Sep 2008 15:04:31 -0400 (EDT)
In-Reply-To: <20080928050828.GZ23137@genesis.frugalware.org>
X-Mailer: Apple Mail (2.929.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96983>


On 28 Sep 2008, at 12:08 AM, Miklos Vajna wrote:

> On Sat, Sep 27, 2008 at 08:09:49PM -0500, Michael Witten <mfwitten@MIT.EDU 
> > wrote:
>> Specifically, boolean options are now listed in the form
>>
>>    --[no-]option
>>
>> and both forms of documentation now consistently use
>>
>>    --[no-]signed-off-by-cc
>
> I don't think documenting --no-foo in the perl script itself is a good
> idea. See c3170a8 (git-merge: exclude unnecessary options from
> OPTIONS_SPEC, 2008-05-12) which removes --no-foo from git-merge as  
> well.
>
> Of course the man page part makes sense.

I like that it's in the help usage text, because it makes it clear how
it should be used.

Besides, I basically removed the same kind of cruft that was removed
with c3170a8, but I still managed to include the same information.
