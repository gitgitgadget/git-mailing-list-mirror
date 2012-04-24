From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to merge the diff file in the git repositry
Date: Mon, 23 Apr 2012 21:25:20 -0500
Message-ID: <4F960F10.8020804@gmail.com>
References: <1335145132814-7490516.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: vamsi <vamsineelam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMVRa-0007uV-4C
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 04:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441Ab2DXCZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 22:25:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46797 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab2DXCZX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 22:25:23 -0400
Received: by obbta14 with SMTP id ta14so373892obb.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 19:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xYKljZerJOpoQZkEVo7okjPSQJ0fj1LhiLk/Tylg7r8=;
        b=LznLys5tfqsO36bvKD6ExiDzvUH3WcUA2tCQWwnKvIz0UGN5a7C/2QwvUWNqAsOX++
         ELzF4aU4u/osWo3KtbOTyojr4l26lNvX5pxSclUcQ3zhU3RKD6HnkRxb8lUWhRyI7u9H
         hZUleaTRBJ/+a/Jve7SDWwz9E+Z2pd5g0KFhQMa6E/3WrB6IKGuF5W8b5W6/OA+qMhYB
         vLSuWeb0C6ud942zXcI6lbZzYv844O/07jqEliMjduFAnHzh5xcbhLc5QVotZxTu5QB3
         hsOkH15Vb1BQvyaUaz3ODhUPZqZ5h0CXM3q7YWK/HW4Wf+1CoJYo3QaGbcQavRMSUNY+
         Vw2Q==
Received: by 10.60.14.36 with SMTP id m4mr25322766oec.37.1335234322339;
        Mon, 23 Apr 2012 19:25:22 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id ch5sm18576349obb.16.2012.04.23.19.25.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 19:25:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1335145132814-7490516.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196180>

On 4/22/2012 8:38 PM, vamsi wrote:
> hii ,
>
> i have a diff file.how to add these modifications to the git repositry
>
>
>
> diff --git a/board/Maxim/maximasp_eek/board_init.S
>
> b/board/Maxim/maximasp_eek/board_init.S
>
> index ec57078..bd55877 100644
>
> --- a/board/Maxim/maximasp_eek/board_init.S
>
> +++ b/board/Maxim/maximasp_eek/board_init.S
>
> @@ -13,7 +13,7 @@
>
> #define ENABLE_DLL
>
>
>
> #define GCR_SETUP      /* Modify GCR register */
>
> -#define GCR_UBP                /* UCI bypass */
>
> +#undef  GCR_UBP                /* UCI bypass */
>
> #undef  GCR_PBEN       /* Enable pass bridge */
>
> #undef  GCR_PBFB       /* Enable burst in pass bridge */
>
> #undef  GCR_ADK                /* Use ADK bridge */
>
> diff --git a/include/configs/maximasp-eek.h b/include/configs/maximasp-eek.h
> index 897f4ab..c9e3965 100644
>
> --- a/include/configs/maximasp-eek.h
>
> +++ b/include/configs/maximasp-eek.h
>
> @@ -23,13 +23,13 @@
>
> #define __CONFIG_H
>
>
>
> #define CONFIG_SYS_USE_DDR     /* Use DDR instead of PSRAM */
>
> -#define CONFIG_SYS_SYNC_MEM    /* Synchronous memory */
>
> +//#define CONFIG_SYS_SYNC_MEM  /* Synchronous memory */
>
>
>
> /*
>
>    * CPU Clock - 16x crystal (20 MHz ->  320 MHz, 24 MHz ->  384 MHz)
>
>    */
>
> -//#define CONFIG_SYS_CPU_CLOCK         384000000
>
> -#define CONFIG_SYS_CPU_CLOCK           320000000
>
> +#define CONFIG_SYS_CPU_CLOCK           384000000
>
> +//#define CONFIG_SYS_CPU_CLOCK         320000000
>
>
> /*
>
>    * Physical Memory Map
>
> regards
>
> Git newbie
>
> --
> View this message in context: http://git.661346.n2.nabble.com/How-to-merge-the-diff-file-in-the-git-repositry-tp7490516p7490516.html
> Sent from the git mailing list archive at Nabble.com.

Does the git-apply manpage tell you what you need?

v/r,
neal
