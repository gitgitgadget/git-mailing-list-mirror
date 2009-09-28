From: Nasser Grainawi <nasser@codeaurora.org>
Subject: [JGIT] patch-id
Date: Mon, 28 Sep 2009 16:21:00 -0600
Organization: Code Aurora Forum
Message-ID: <4AC136CC.8040300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 00:21:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsOah-00021M-Lu
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 00:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbZI1WU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 18:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZI1WU5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 18:20:57 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:6346 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbZI1WU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 18:20:57 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5755"; a="24257499"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 28 Sep 2009 15:21:01 -0700
Received: from [129.46.10.111] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id D9DBE10004DB;
	Mon, 28 Sep 2009 15:23:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129275>

Hello again,

I'm trying to add a public getPatchId method to the jgit Patch class and I
came up with some questions. Shawn previously mentioned that Patch already
does the parsing of the patch; however, I can't quite wrap my head around
how/where/if data from that parsing is stored.

It seems Patch does some statistical number gathering, but at no point does
it store a 'slimmed-down' version of a patch. I had the idea to just iterate
over the FileHeader's and get the byte buffer of each, but I don't think
those buffers have the parsed data.

If I've mis-read the code (quite possible), someone please let me know.
Short of that, suggestions for how to go about acquiring/storing a parsed
representation of the data with maximal existing code re-use would be
appreciated.

Thanks,
Nasser
