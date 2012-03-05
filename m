From: Paul Betts <paul@paulbetts.org>
Subject: Re: Path character encodings
Date: Mon, 5 Mar 2012 14:02:32 -0800
Message-ID: <20120305220232.GA18247@jupiter.local>
References: <20120305212657.GA17903@jupiter.local>
 <7vipiizpyn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4fzM-00030q-9k
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 23:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab2CEWCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 17:02:36 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60133 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab2CEWCf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 17:02:35 -0500
Received: by pbcun15 with SMTP id un15so3265267pbc.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 14:02:35 -0800 (PST)
Received-SPF: pass (google.com: domain of paul@paulbetts.org designates 10.68.232.162 as permitted sender) client-ip=10.68.232.162;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of paul@paulbetts.org designates 10.68.232.162 as permitted sender) smtp.mail=paul@paulbetts.org
Received: from mr.google.com ([10.68.232.162])
        by 10.68.232.162 with SMTP id tp2mr44093862pbc.165.1330984955297 (num_hops = 1);
        Mon, 05 Mar 2012 14:02:35 -0800 (PST)
Received: by 10.68.232.162 with SMTP id tp2mr38052689pbc.165.1330984955248;
        Mon, 05 Mar 2012 14:02:35 -0800 (PST)
Received: from localhost (c-67-169-43-61.hsd1.ca.comcast.net. [67.169.43.61])
        by mx.google.com with ESMTPS id x6sm14349241pbp.31.2012.03.05.14.02.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 14:02:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vipiizpyn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlHaScLzrpIe1P/SIqIO/wDuoUj1q7uuK+didlBdMM2Emel/hPSx2W9FiFqwlD5OmKcRBVh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192279>

Hi Junio,

On Mon, Mar 05, 2012 at 01:40:32PM -0800, Junio C Hamano wrote:
> Hmph, I do not see a reason to make a huge molehill in this. The
> pathnames are of unspecified encoding, and if a project declares
> that they always use UTF-8, that would be great. 

I would like to propose, that Git codifies-as-required the majority case
today, that trees should *only* be encoded in UTF-8 going forward. 

> Why does git itself have to do anything about it, and how would it help
> users without hurting other git users who are not involved in such a
> project?

My concern is that users will not know what's happening or how to fix it,
they'll just see messed up paths and assume Git is broken. Even a warning
message would give users something explicit to put into Google to find a
solution for. Not many people will possess the Git-Fu required to manage
filter-branch. 

-- 
Paul Betts <paul@paulbetts.org>
