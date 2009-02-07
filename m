From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Sat, 7 Feb 2009 23:09:49 +0200
Message-ID: <94a0d4530902071309l7c34945ana2af31e41707fa0c@mail.gmail.com>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
	 <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0902050049240.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVuXy-0008EJ-PF
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbZBGVJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZBGVJv
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:09:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:56884 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZBGVJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:09:51 -0500
Received: by fg-out-1718.google.com with SMTP id 16so797472fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mbgSMCPgZEe4R7gZk1rcbGCYEFpfyXZrQ/WyVYAkaBY=;
        b=EBl4saZC+e5Zl2PtD8kwlA47ZYGH3+JgzIhHg4/QHqGzRi/WmyuWlHJHjDCmjftxac
         pmtu6tqhpeyWrSdAYfT6a2itIIagWbMcpHvcBtEKKsZz3c0M/kAKDBZorSD9VxaGhzEi
         5Pe0WN1+BL/AGHT4E0qWKB97v4MtoumPjyg9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZI//s5xieQrC0THyR6I0rLeuERMWs3WN3Rubqja/BQYTvQ7/A+77PO3CIMH7W/hZKi
         JogkR+t5keCzhS3+1BvT6eKcbfNz8pqZR3C2/Rnwpl3E+oPebIRT3KyO80X5CtHWehFU
         xWU1+nVk+vfrB0p7Le2WV/dEEiahwrEmPKwSw=
Received: by 10.86.93.19 with SMTP id q19mr1817221fgb.62.1234040989074; Sat, 
	07 Feb 2009 13:09:49 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902050049240.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108882>

On Thu, Feb 5, 2009 at 1:49 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 5 Feb 2009, Johannes Schindelin wrote:
>
>> On Wed, 4 Feb 2009, Junio C Hamano wrote:
>>
>> > Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >
>> > > The idea was originated by discussion about usability of manually
>> > > editing the config file in 'special needs' systems such as Windows. Now
>> > > the user can forget a bit about where the config files actually are.
>> >
>> > Does this honor core.editor setting in existing configuration files?
>>
>> It should, as it uses launch_editor().
>
> Oh, I see that launch_editor() does not do its own git_config() parsing.
> Dunno if it should...

I think it should, how expensive would it be to call
git_config(git_default_config, NULL) when it has been loaded already?

-- 
Felipe Contreras
