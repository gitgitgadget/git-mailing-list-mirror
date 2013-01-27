From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 03/10] t/t3511: add some tests of 'cherry-pick -s'
 functionality
Date: Sun, 27 Jan 2013 15:40:14 -0800
Message-ID: <20130127234014.GB8206@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-4-git-send-email-drafnel@gmail.com>
 <20130122081758.GD6085@elie.Belkin>
 <CA+sFfMc0_QxwtJ6YS6H+GOW+Pzh3tSZs3rW-VSDf-GWeL=3tDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzbq7-00061F-5d
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab3A0XkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:40:21 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:63521 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab3A0XkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:40:20 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so1125979pbb.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jFQA9QmR1HlZveMKZWyna1KSFEuphK7v7Lk94ghBolc=;
        b=AQSFoz1cPHrkYWVbQ/3KxVPtVp84pL1ybOpPiZdvIIOsMRBqJY24lqjO9hEGa9teLr
         LQz6QKbQHYirIfQYZ8JglMfqqly3TfShz01TWZnqN/cs2gWCReKaMG0bjmRbP9KiiStd
         /oyxmymrfN267PBdKjZ0saD0ChzB9gTmMuGuskCJw9Ju4HPb/YX+PSDPrXcSpTB48Vsj
         VU0De5BuLMb7ceaqH7/Htz0T4fZvO426dMxyeEv4kMn/E/KcQHG8LtyBz9IaSVSq4Jje
         7prG7ndjIeAJevGWWzKGHMu9sE1Dh6JKhUKsxlmc254vYbkGxOUXRWpM3iqwpStvvmFG
         3wmg==
X-Received: by 10.68.233.201 with SMTP id ty9mr33632930pbc.14.1359330020233;
        Sun, 27 Jan 2013 15:40:20 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qo10sm5078692pbc.58.2013.01.27.15.40.17
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 15:40:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+sFfMc0_QxwtJ6YS6H+GOW+Pzh3tSZs3rW-VSDf-GWeL=3tDA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214753>

Brandon Casey wrote:

>                                                            I'll tweak
> the string so it looks like this:
>
> The signed-off-by string should begin with the words Signed-off-by followed
> by a colon and space, and then the signers name and email address. e.g.
> Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>

Yep, that looks better than the example I suggested. :)

[...]
> On Tue, Jan 22, 2013 at 12:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> One more test would be interesting: what does "-s" do when asked to
>> produce a duplicate signoff with an interspersed signoff by someone else?
[...]
> This one exists as "adds sob when last sob doesn't match committer".

So it does.  Thanks for the sanity check.
