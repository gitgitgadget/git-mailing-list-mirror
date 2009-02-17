From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] config: Use parseopt.
Date: Tue, 17 Feb 2009 15:21:01 +0200
Message-ID: <94a0d4530902170521w71127810y188d27faaf1f2b83@mail.gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
	 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
	 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
	 <7vab8laa7p.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902170235g4e481e07t39a6157894dff9aa@mail.gmail.com>
	 <alpine.DEB.1.00.0902171255220.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 14:23:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZPv3-0006R9-6I
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbZBQNVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbZBQNVE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:21:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:24575 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZBQNVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:21:03 -0500
Received: by fg-out-1718.google.com with SMTP id 16so410354fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bdKDe0Dcu0F9vO2IFjph3i6tzrpICLHdnnqWdzZpCq8=;
        b=ZZh70916GXBF6ci2Js5wLBTAAACJl/+s25GAr3FGtUeZ4xSgwgDTdIZPmTbJTj+Aev
         /D/t1Ypa97E29FP+8NY6RK0FA1FMAoU/CNzH5PQvCEjxYml6scbnSY3bOGKTQplLHI2I
         zvrUaRA60+sn9dnpp0HUfjQTibIwH3vn55cn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xwFo2p7RAeRNIGzNO+bwVTvzdJjXebZJj08SCjlF/8k0wFEjYoUMBO53CjEHAo2m3Z
         4RqtkWbYfK3fPIGGejQ0cZnjRgpYNjOEnX43ijE1Mgkz12q4qDoz+2ba9bYt4pVvtb5M
         pbes/ug3DJj7VpF5I0uA4Fuv384sFG7Gx09/s=
Received: by 10.86.73.1 with SMTP id v1mr2041196fga.52.1234876861578; Tue, 17 
	Feb 2009 05:21:01 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171255220.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110368>

On Tue, Feb 17, 2009 at 1:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 17 Feb 2009, Felipe Contreras wrote:
>
>> On Tue, Feb 17, 2009 at 7:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> > I've queued the entire series on top of fc/config-editor topic and even
>> > merged the result in 'pu' once, but I had to reintegrate 'pu' without the
>> > series.
>> >
>> > Before this commit, t/t1300-repo-config.sh passes, but this one breaks
>> > the test.
>>
>> Ah, I didn't know there was a test for that.
>>
>> I've fixed most the issues but unfortunately parseopt barfs when -1 is
>> used as an argument. That should be fixed somehow, otherwise this
>> patch will never pass the test.
>
> Have you seen PARSE_OPT_STOP_AT_NON_OPTION?

Thanks, that works... cooking up a new series.

-- 
Felipe Contreras
