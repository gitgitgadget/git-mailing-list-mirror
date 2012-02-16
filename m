From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Identify Commit ID from an Extracted Source Snapshot
Date: Fri, 17 Feb 2012 00:00:12 +0100
Message-ID: <4F3D8A7C.2020400@elegosoft.com>
References: <BEDA323D25EF6045A68DAB9FD91A0BF123A85B38@DB3PRD0402MB118.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: James Walmsley <james@fullfat-fs.co.uk>
X-From: git-owner@vger.kernel.org Fri Feb 17 00:01:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyAKU-0008Fd-JY
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 00:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab2BPXBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 18:01:30 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58089 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695Ab2BPXB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 18:01:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 567FCDE8CA;
	Fri, 17 Feb 2012 00:01:28 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7DJqdmcNS2bB; Fri, 17 Feb 2012 00:01:28 +0100 (CET)
Received: from [192.168.1.101] (g231216233.adsl.alicedsl.de [92.231.216.233])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 198E2DE8C8;
	Fri, 17 Feb 2012 00:01:28 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120212 Thunderbird/10.0.1
In-Reply-To: <BEDA323D25EF6045A68DAB9FD91A0BF123A85B38@DB3PRD0402MB118.eurprd04.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190919>

On 02/16/2012 11:06 PM, James Walmsley wrote:
> I couldn't find this on google, and I have no idea if its even
> possible. I have several zip files from previous versions of my
> source code. (I imported svn into git). I would like to add TAGS to
> git which represent the versions based on the files in my zip
> archives.
> 
> Does anyone know how to do this?

If it's just about providing the ancient code together with the
(imported) more recent history from SVN, you could create an extra
orphan branch for each zip packet, add the files, commit and
eventually tag.

If your question is more like "how do I tell git to find out where
this old code fits in my history and eventually place it there",
the answer is: you cannot do it. No VCS will do this and especially
not Git.
