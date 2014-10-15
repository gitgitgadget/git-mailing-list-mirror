From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: add an option for writing to a temporary
 directory
Date: Tue, 14 Oct 2014 23:38:49 -0700
Message-ID: <20141015063848.GC14751@gmail.com>
References: <1413047085-12398-1-git-send-email-davvid@gmail.com>
 <xmqqk3433h8m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:38:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeIED-0004ie-QM
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 08:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaJOGia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 02:38:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:49687 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaJOGi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 02:38:29 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so723000pab.23
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 23:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iYsryjeVMlFW57gAMeGj2bsQ9QeK8XIoXlwmNARTOCw=;
        b=wUZVw7RSOOBGRGrzEugf8A6j53jTtVxpFCvxNaVMEs8xakLFO+Zv8I/Ff16c0T5ZDI
         CDGxO2gMLwmEFxRzxQikYpR7BW9PIyF8sOrxco+rHVJYJXgqQDF60ngR4G824HEtJofK
         9OMfnor5niPwOGLS6qZTg1iwX/2G16hNlsHKwM4FOvlIZ+es+6O1GkOv/4YSkPGk4tcw
         uGDfImVVfINCD/rDr5r13VuNsRSdK6GZJqibIoPDgWfvaU4CQAh1vutqMIGfKgrW+C7y
         qX7vSJ0h6Fv0s6xiVUVRHxm4wH0rjWBKykDanbjI1zSGkYtSzKteRZYgtF/teTH9wRB/
         eK9A==
X-Received: by 10.68.249.133 with SMTP id yu5mr10185139pbc.31.1413355109069;
        Tue, 14 Oct 2014 23:38:29 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id a12sm2100762pdm.64.2014.10.14.23.38.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 23:38:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqk3433h8m.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 12:24:41PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Teach mergetool to write files in a temporary directory when
> > 'mergetool.writeToTemp' is true.
> >
> > This is helpful for tools such as Eclipse which cannot cope with
> > multiple copies of the same file in the worktree.
> 
> With this can we drop the "change the temporary file name" patch by
> Robin Rosenberg?
> 
> http://thread.gmane.org/gmane.comp.version-control.git/255457/focus=255599
> 
> Message-Id: <1408607240-11369-1-git-send-email-robin.rosenberg@dewire.com>

I would think so but I'm biased ;-)
-- 
David
