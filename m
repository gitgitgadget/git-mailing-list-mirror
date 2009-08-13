From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 10:09:41 -0700
Message-ID: <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> 
	<1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com> 
	<20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302> 
	<20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> 
	<20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbdor-0001XF-Gh
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbZHMRKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbZHMRKD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:10:03 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47284 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbZHMRKB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:10:01 -0400
Received: by ewy10 with SMTP id 10so937840ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Zkg/3OWkXyHcZgnj0v6kANBNjKv/aHEHfim2hg1sv24=;
        b=VGVEEqLwMIVmHcK6M8CugKZ8hedzi85aO+mWhHmhE2Hmk0c2uXa9XAgaqCooB7csLj
         q2SY6SIX5arNepgbNR8Jvaw3U7ekomJN9cnfgGIhgr3gS4+ERleURwMiKYF4/bpVaAKI
         ZzJQGBrvjQBtbZ0N6PN1Y5iOtgzJQ29fucsug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HC+VZySf3MJIsiyhrKgynKKNz62YxwkZKjLChB/JT+MU/yUYnns9PiyK+QIA1qFfQ0
         eOMkHX4azFzz/BfD1+6+oCXqIcHsu1kKLDUFL3EDFEDn19WzJ/gwbPSf5x6DDhBjzyrg
         O/dVTOhGdApmoTEF8vI3nHLTzpRWnD5X9HCpw=
Received: by 10.216.0.84 with SMTP id 62mr192800wea.185.1250183401132; Thu, 13 
	Aug 2009 10:10:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125840>

Heya,

On Thu, Aug 13, 2009 at 10:07, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> ... and will import the marks twice?

Ah, you're right :(. What's the best way to do this? Should we dump
any previous marks when importing new ones?

-- 
Cheers,

Sverre Rabbelier
