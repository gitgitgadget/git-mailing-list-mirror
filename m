From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: don't let revert continue a cherry-pick
Date: Sun, 8 Jan 2012 14:45:39 -0600
Message-ID: <20120108204539.GO1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-4-git-send-email-artagnon@gmail.com>
 <20120108193749.GH1942@burratino>
 <CALkWK0=-AWy7HnVASB1rt8njavTYOhV7Zxsdq4TE+VShVZmEzQ@mail.gmail.com>
 <20120108202216.GL1942@burratino>
 <CALkWK0kwbzXRyFf=JjfAW9yD7M_FTB80+q1UPOCv-Em4qO2RKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:40:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzXh-0007vS-Lz
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab2AHUkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 15:40:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50805 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab2AHUkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 15:40:32 -0500
Received: by yenm11 with SMTP id m11so1292860yen.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k4U1LsF0cUz3W9naehdRf5BOB/r/Ue8/jH5N1j2KoGA=;
        b=CR8/yzED1G4EVxBaLA76uncTn7CxQIQ3l77eTlJAn0Nq8YIh1rqk/+eo+Jdt5GDiHH
         Mt/Vfb+xm8pupN0nnR4NF0DYFBdLBkcO/yCHNFwpuvx+a0luDw/CJvcc1XGQhtfdGi55
         X+iJmzm7DEhcxlc27Avpj26V/c+mxoBmZNDbA=
Received: by 10.236.183.52 with SMTP id p40mr16934758yhm.19.1326055232258;
        Sun, 08 Jan 2012 12:40:32 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d5sm99003290yhl.19.2012.01.08.12.40.31
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 12:40:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kwbzXRyFf=JjfAW9yD7M_FTB80+q1UPOCv-Em4qO2RKQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188132>

Ramkumar Ramachandra wrote:

> In retrospect, I think we should simply drop
> this patch.

Great --- I don't think it had much to do with this series.

I'll keep this mail in my inbox.  Who knows --- maybe I'll get a
moment to teach conflicted single-picks to write a
.git/sequencer/when-continuing-just-continue-the-single-pick file.
