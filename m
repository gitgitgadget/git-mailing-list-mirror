From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Reset by checkout?
Date: Tue, 03 Jun 2014 16:48:09 -0500
Message-ID: <538e429981ec_77a9ef30482@nysa.notmuch>
References: <20140531144610.754B.B013761@chejz.com>
 <53898448.8040105@bracey.fi>
 <20140601132624.821C.B013761@chejz.com>
 <538AE814.2010407@bracey.fi>
 <xmqqmwdv2d08.fsf@gitster.dls.corp.google.com>
 <538E26A1.5020509@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nakagawa <atnak@chejz.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwZ6-0003WB-QW
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbaFCVsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:48:12 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:42834 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbaFCVsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:48:11 -0400
Received: by mail-oa0-f44.google.com with SMTP id o6so6921635oag.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GobOvjlt4xIcGv+p3ma9maSD0PcY9d1lEdkGPGs24lE=;
        b=czqj3qqd8GHcuVCQOBctPuQjaQK1PcKlN0LjJMxAFlFDjWvp1W3QewjS2DV9gNsbDE
         A8qmiYh2OyFGQ8usvdKpgL+llJheSawRj1kgrE5pU3UuBm0ujrWUYZddRCifZ9nNkp9l
         e2+7m9zufp6Qg/iRlNIeVOvdMHRfSleoFJCyHb9I+DJocDAUgR7aPdgDMPw+dZvrpqk8
         enZU8W5lBW6cOqhXw1z7oH+tPNrbKruocJ6fsKaAYJDaYzgYg0qEUpxuN6d5hMV/n4/O
         0xOWRISQg4NKmGak93YpX7Gb4z7jKIt6NcocjWwCwCIZUK10YbAv+WOfoCcJibtox/6e
         w66g==
X-Received: by 10.60.33.199 with SMTP id t7mr16075181oei.73.1401832090743;
        Tue, 03 Jun 2014 14:48:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w8sm1605060oel.14.2014.06.03.14.48.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jun 2014 14:48:10 -0700 (PDT)
In-Reply-To: <538E26A1.5020509@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250690>

Kevin Bracey wrote:
> Maybe we just need to tighten up the EXAMPLES section? Give it
> easy-to-locate <path>/--soft/--mixed/--keep subheadings, covering all
> those common use cases (in clean trees...), including a before/after
> git status views. Then normal users could skip the top technical
> section waffling about indexes and go straight there instead.

Or maybe we need to have sane options, like --stage, --work, and --keep.

-- 
Felipe Contreras
