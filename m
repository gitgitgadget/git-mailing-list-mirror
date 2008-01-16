From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 15:06:13 +1100
Message-ID: <ee77f5c20801152006w11307ce0j17463f1c6536543f@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzY3-0000Wm-47
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbYAPEGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYAPEGO
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:06:14 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:8235 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbYAPEGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:06:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so177337wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 20:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hanGB228jMWplbQXBsyMts5VCeFTnvcv87jpf4bmfKg=;
        b=RVtkzG8jvtf0Sg4wS7DbyuVleQ88jBojEJtPT5+RBKFCQeGf8KvUNmsrftD4DHBtn9PvvbeyraKqbV4jIxHB+2KlouizV+UuxfsZ6qH6OwIz77BpibytvPMn3ON58dblYye3eesvqPDdzqu9FUXXofbqRV1qghjO4zD9oPISpLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AJnKD4PC2gYfVu4m682NSGcMtfDTn5SiHo2nPHuip8XjhedM2wJsUD7NZp4VtFexOKL3uo/od/14pFPfVSF4BkgDDkdrFiiRLJ/PxH/wlP4OHs/1ZaKpdUdUkizQufVItw4g/tOScdLV0IFNPKg085kd3W5hxQrs9YMZPm+2pPI=
Received: by 10.140.251.1 with SMTP id y1mr237292rvh.11.1200456373513;
        Tue, 15 Jan 2008 20:06:13 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Tue, 15 Jan 2008 20:06:13 -0800 (PST)
In-Reply-To: <478D79BD.7060006@talkingspider.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70617>

On Jan 16, 2008 2:27 PM, Mike <fromlists@talkingspider.com> wrote:
>
> 2. If I tar/gz my code and deliver it to a client, I don't want the .git
> dir slipping into the tarball, allowing my client to be able to peruse
> the history of what we did and when.

Use git-archive.


Dave.
