From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 10:35:37 +0100
Message-ID: <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Fabian Seoane" <fabian@fseoane.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 10:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5GpM-0006MS-5J
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 10:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbYKZJfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 04:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYKZJfk
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 04:35:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:36241 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbYKZJfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 04:35:39 -0500
Received: by fg-out-1718.google.com with SMTP id 19so254149fgg.17
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 01:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=kMq1TKlGar+GtHsR/1k9UAH2Q6Z9cFoXWwXIahpfhUg=;
        b=qdn67YLUHSke3a9uJ0qtMxhNxBoRrMuM4K9tjF/0irWNEB7NIC4tt1QOhy6hRupNzQ
         6LSg80YugJU8f68Dlt+lM9POg2F2B9OUI+PVt07cmJjqAcdqWh373qvel+fVKCAhTzcj
         UekoEapJ2p30K54Tb1eLOwTu1B/vpi0QeYGdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=PiExKUfLS+BfOc8Q7E8cY2j7iK3ZVvE9uJZgbofQwg8rQhF5Cibzjp/tv9fhXu6OiY
         zWJCj0AlwcAW4682EJWBCHdIk4BBpvdPdIfyNscVnge1Si9Vu1u8muxrXLfb8WjvQS1y
         M7lBkw4z9SX5Pih6IIO6PIC3G+MgjrJRYP0t4=
Received: by 10.86.93.17 with SMTP id q17mr3675280fgb.50.1227692138036;
        Wed, 26 Nov 2008 01:35:38 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Wed, 26 Nov 2008 01:35:37 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 172230deab5e166c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101716>

On Wed, Nov 26, 2008 at 1:14 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 25 Nov 2008, Ondrej Certik wrote:
>
>> I would like to export our whole git repository to patches, and then
>> reconstruct it again from scratch. Following the man page of "git
>> fast-export":
>>
>> [...]
>>
>> However, the repository is very different to the original one. It
>> contains only 191 patches:
>
> Can you try again with a Git version that contains the commit
> 2075ffb5(fast-export: use an unsorted string list for extra_refs)?

I tried the next branch:

$ git --version
git version 1.6.0.4.1060.g9433b

that contains the 2075ffb5 patch. I haven't observed any change ---
the "git log" still only shows 191 commits (git log --all shows
everything).

Ondrej
