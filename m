From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Conforming to pep8
Date: Fri, 09 May 2014 02:35:34 -0500
Message-ID: <536c8546ed6fd_182dd0d3100@nysa.notmuch>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
 <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
 <20140509051623.GB9051@wst420>
 <536c815ee0b9c_182dd0d3104b@nysa.notmuch>
 <20140509072820.GD9051@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com
To: William Giokas <1007380@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 09:35:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WifLM-0005rW-TE
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbaEIHfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:35:40 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:59750 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbaEIHfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:35:40 -0400
Received: by mail-yh0-f43.google.com with SMTP id f10so3400164yha.2
        for <git@vger.kernel.org>; Fri, 09 May 2014 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=QHGhKWz2/kWPTrGrUhod1OKbT5/priDV/ruOB8p9JD0=;
        b=TEe1u9QF9mJCzQZidguyAe2n5Slo7JAFJlkAVIxMhZiayb2JuKZfBDNBo4IowsWBmy
         C6mp+dA/7BDB8PZPIoNmDnH/s0/6WzgOZ3OQTpf4bT+o/pLXWmCoUPwbIB6Lu1wsx7xU
         7ubvTSdkj8FtMxvnU9VtHJn50appBXq+WvKywEc3HasLFZp00XSDJlKx950R/2HYCmAy
         rAuZ2xQ3bi/e4xVtkhE2F3YvjN6ET4XOP1Wn9gEk81lV6TCuKiqCs7RtUVT8FuzuOREU
         Jq4esIXKhRJFILf2U6p5WO/wwTKcLZTpqNXVnbk6Jd1tzEEIcgS+lZo585Hjckg6BYQA
         UtxQ==
X-Received: by 10.236.132.134 with SMTP id o6mr11894774yhi.147.1399620939714;
        Fri, 09 May 2014 00:35:39 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d43sm5088267yhb.10.2014.05.09.00.35.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 00:35:38 -0700 (PDT)
In-Reply-To: <20140509072820.GD9051@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248524>

William Giokas wrote:
> On Fri, May 09, 2014 at 02:18:54AM -0500, Felipe Contreras wrote:
> > William Giokas wrote:
> > > On Thu, May 08, 2014 at 11:36:29PM -0500, Felipe Contreras wrote:
> > > > William Giokas wrote:
> > > > > E401: Multi-line imports seems like something that would just be
> > > > > changing one line
> > > > 
> > > > Yes, and make the code very annoying.
> > > 
> > > It's 1 extra line in git-remote-hg, and 4 lines in git-remote-bzr.
> > 
> > Ah, it refers to the '^import *' not '^from x import'. That's fine then.
> 
> Yeah. In fact, for the mercurial stuff the `from mercurial import changegroup`
> line should be on the same line as the other `from mercurial import ...`
> line.

I think the line is too big, it should be rearranged. But every time I
add something to that list I say: I'll clean it up later =/

-- 
Felipe Contreras
