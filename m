From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 09:26:41 -0700
Message-ID: <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> 
	<1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com> 
	<20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302> 
	<20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> 
	<20090813152419.GN1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbd9B-0007Xg-OC
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 18:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbZHMQ1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 12:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZHMQ1B
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 12:27:01 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:44480 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbZHMQ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 12:27:00 -0400
Received: by ewy10 with SMTP id 10so907405ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MdZYkJmxMA8HEClUukJx2RW0sacrrRfC+7lI68MeZN0=;
        b=dE+FTruVe6f/cM5459oTuNgznr29ZP1bTn006GDyWxJzzOl7eMncBOPLimP4xUBKAd
         vIMpNgAFOtelwBx+ygvPU2A1SzQPL0P2D7gG+LlRsxQcdUmK2bFSWYEDZ5SkvfSfE3fV
         30rNbycAAzBkM88FQHLj7EJiM/pB0PJLUQze8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gHORrJofSIlLB+q7nTuU+SGzSK31HIm2oNrVbGz4jzMWkfAs7QDYcNdX/9QMlXwpmT
         fwejRDJM+dcuRCfFUXwRZ54//IzY7tXTtub5GtHMAPkt8/pZ5acxxZ0I09yGspfvZ/Iy
         aeIfdvHAS9OpD/Z0YHjylhngFM4Tuk2TnqXQk=
Received: by 10.216.85.203 with SMTP id u53mr197860wee.86.1250180821117; Thu, 
	13 Aug 2009 09:27:01 -0700 (PDT)
In-Reply-To: <20090813152419.GN1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125830>

Heya,

On Thu, Aug 13, 2009 at 08:24, Shawn O. Pearce<spearce@spearce.org> wrote:
> Why shouldn't I be able to (easily) override the marks location
> locally, without resorting to stream editing?

You convinced me, I'll store argv and argc in global_argv/global_argc
and move the option parsing to parse_argv(), which is then called when
the first non_option command is parsed.

-- 
Cheers,

Sverre Rabbelier
