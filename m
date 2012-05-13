From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Index format v5
Date: Sun, 13 May 2012 22:01:44 +0100
Organization: OPDS
Message-ID: <D4710CB39C254E8DA3B9778366145718@PhilipOakley>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <trast@student.ethz.ch>, <gitster@pobox.com>,
	<mhagger@alum.mit.edu>, <peff@peff.net>, <spearce@spearce.org>,
	<davidbarr@google.com>
To: "Thomas Gummerer" <t.gummerer@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 13 23:01:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STfuy-0008E6-Gw
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 23:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab2EMVBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 17:01:23 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:15450 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751644Ab2EMVBX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 17:01:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqwMAC8gsE9cHlGK/2dsb2JhbABFi0GmfwECgR2BCIIQAQQBAQQBCAEBLh4BARwFCwIDBQIBAw4HAQslFAEECBIGBxcGARIIAgECAwGFOAcBgicIAwYJB69LDYlTiixuYjI/g1JjBIgwhUqJFIoshQOCag
X-IronPort-AV: E=Sophos;i="4.75,582,1330905600"; 
   d="scan'208";a="371889283"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip04ir2.opaltelecom.net with SMTP; 13 May 2012 22:01:20 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197754>

From: "Thomas Gummerer" <t.gummerer@gmail.com> Sent: Thursday, May 03, 2012 6:25 PM
> I have been drafting the Version 5 of the index format over the past
> few days with the help of Thomas Rast, Michael Haggerty, cmn and
> barrbrain on IRC. 

>
> GIT index format
> ================
>
> = The git index file has the following format
>

Given the discussions on the list about the general naming of Staging vs Index [1], 
would a careful change to the title, and the adding of an introductory line 
help in putting the index file format in the appropriate (implementation) context?

I'm thinking that perhaps -
Title: "GIT index file format (V5)", i.e. add the 'file' qualifier.

Introduction line:
"The git index file (.git/index) documents the status of the files in the git staging area."
    i.e. this is an implementation document for this particular file, but using the terms
    suggested in [1]. Followed by
"The staging area is used for preparing commits, merging, etc.".
   i.e. show the purpose of this index relative to the overall 'staging area'. 
   IIRC the use of the staging area for merging was one of Linus's key features;-)

By crafting the title and the introduction line(s) the confusion e.g. [2], between implementation 
details (this document) and conceptual operation can be clearly separated.

Philip

[1] http://article.gmane.org/gmane.comp.version-control.git/197111 
    [1.8.0] use 'stage' term consistently

[2] http://raflabs.com/blogs/silence-is-foo/2011/04/07/staging-area-index-cache-git/
    ... Git it's a little bit confusing to undersand some of its terminology
