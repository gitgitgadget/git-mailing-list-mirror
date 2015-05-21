From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 5/5] help: respect new common command grouping
Date: Thu, 21 May 2015 10:15:26 -0700
Message-ID: <xmqqsiapkg29.fsf@gitster.dls.corp.google.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432213989-3932-6-git-send-email-sebastien.guimmara@gmail.com>
	<CAPig+cRX9_1h4W6sWxb22FF3Hwgqx2f=hK=tQkfTUdkTJiQo-w@mail.gmail.com>
	<xmqqiobllxdk.fsf@gitster.dls.corp.google.com>
	<CAPig+cT65MpPYaE4BxajMNU2N=rf6QQzsxDsc7fV-_GMPVcdhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 21 19:15:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvU4K-0001nZ-R1
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbbEURPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:15:36 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36492 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbEURPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:15:34 -0400
Received: by igbpi8 with SMTP id pi8so15445614igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9KybtSj3juscPS9GBpvlPpNmbLwWU+uh/iqGsJrf6qA=;
        b=zgVsdT4/kHYJfqY9tpU7dEahoFrPzLanRQIcIV1NIVer4GCgIvaQWGjMRbPFbt3Ewb
         xwTjARBiSRRqcLq21Iqo/r7EEyVDx4j3iNxlaasFfMakFGK3fx7oPBuHZ41ryVMv5wCf
         cZRrJ2tSd/swgiIZLv1W84kEWR+JEX5Y3h6JcdEzu59jTZR1f5vjZTLpl7jLa+hLWsrV
         YvDRV/X5RfHVObL4yOIf0h9t+bCPC7H3D3n3UC4dr+vxRZTZZm0v+7LOOYJqIcWkTHCC
         VBBH6lCGhCG5FSItXJAwDx8Rx62fudCTkbSkZfXtiHwT1Vv4bBS/1PU3TfB+nRPtYaFc
         1FPQ==
X-Received: by 10.43.148.72 with SMTP id kf8mr4572022icc.76.1432228533647;
        Thu, 21 May 2015 10:15:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id p74sm15318197ioe.27.2015.05.21.10.15.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 10:15:32 -0700 (PDT)
In-Reply-To: <CAPig+cT65MpPYaE4BxajMNU2N=rf6QQzsxDsc7fV-_GMPVcdhw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 21 May 2015 12:46:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269616>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Hmm, but is it necessary to explain the group labels in the first
> place? The help output (group labels and all) seems self-explanatory
> already, and one would expect (hope) that readers are intelligent
> enough to understand implicitly that the group labels are a simple
> organizational aid.

I am not so sure about that.  For one thing, the groups are not
exhaustive enumeration of all the workflow elements, but just a list
of the more common ones.  I think the target audience of this round,
which is different from the target audience of the "alphabetical
list", range from those who do not have a clue where to start and do
not know how their work that revolves around use of Git could be
structured.  And "not yet being familiar with the way how things are
often done with Git" is certainly different from them being "not
intelligent enough".

More experienced people can do without the explanation, or without
grouping for that matter.  We are not the target audiences.

> Anyhow, it's just a minor observation, and it's something people can
> argue later if they feel strongly about it, so I don't think it should
> hold up this patch series.

Yeah, I agree with that.
