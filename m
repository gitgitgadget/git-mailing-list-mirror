From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 13:07:15 +0200
Message-ID: <4E81AE63.8040008@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk> <201109261539.33437.mfick@codeaurora.org> <201109261552.04946.mfick@codeaurora.org> <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk> <CAGdFq_hvR1MPF33YFcjDCzCM0iOO2zpiiePFFS4dBabu84cwTg@mail.gmail.com> <22f055b34840e3c64f3339f7b3dc6920@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <davidbarr@google.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 13:07:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8VVd-0005oS-8I
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 13:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab1I0LH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 07:07:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33058 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab1I0LH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 07:07:27 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8RB7Fnx020948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 27 Sep 2011 13:07:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <22f055b34840e3c64f3339f7b3dc6920@quantumfyre.co.uk>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182234>

On 09/27/2011 11:01 AM, Julian Phillips wrote:
> It has to be hot-cache, otherwise time taken to read the refs from disk
> will mean that it is always slow.  On my Mac it seems to _always_ be
> slow reading the refs from disk, so even the "fast" case still takes ~17m.

This case should be helped by lazy-loading of loose references, which I
am working on.  So if you develop some benchmarking code, it would help
me with my work.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
