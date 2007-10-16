From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 03:27:18 -0400
Message-ID: <11F85069-1013-4685-9D56-C53F0F8231BF@MIT.EDU>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <20071016070421.GE13801@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhgqG-0003y0-6o
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbXJPH1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbXJPH1k
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:27:40 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:51960 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754767AbXJPH1j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 03:27:39 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9G7RJRO004169;
	Tue, 16 Oct 2007 03:27:25 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9G7RIFq028532
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Oct 2007 03:27:19 -0400 (EDT)
In-Reply-To: <20071016070421.GE13801@spearce.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61102>

On 16 Oct 2007, at 3:04:21 AM, Shawn O. Pearce wrote:

> The C code is all tabs, with the tabs set at 8 spaces, but the
> actual tab width isn't too important here as we never use the tab
> for alignment beyond the left indent.

Consider this from diff-lib.c:

> /* A file entry went away or appeared */
> static void diff_index_show_file(struct rev_info *revs,
> 				 const char *prefix,
> 				 struct cache_entry *ce,
> 				 unsigned char *sha1, unsigned int mode)
> {
> 	diff_addremove(&revs->diffopt, prefix[0], ntohl(mode),
> 		       sha1, ce->name, NULL);
> }

There are mixed tabs and spaces for alignment.

I suppose I'll be fine if I just set tab widths to 8.
But 8 spaces! Good Lord. ;-)

I really hate tabs.

Thanks,
Michael Witten
