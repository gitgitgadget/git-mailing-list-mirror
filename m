From: =?UTF-8?B?QnJhbmtvIMSMaWJlag==?= <brane@wandisco.com>
Subject: Re: reposurgeon now writes Subversion repositories
Date: Thu, 29 Nov 2012 11:31:49 +0100
Organization: WANdisco
Message-ID: <50B73995.5050505@wandisco.com>
References: <20121129055946.2D7B84065F@snark.thyrsus.com> <20121129075829.GE3424@lp-shahaf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: dev@subversion.apache.org
X-From: git-owner@vger.kernel.org Thu Nov 29 11:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te1Pe-0003qd-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 11:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab2K2Kbz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 05:31:55 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:49476 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab2K2Kby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 05:31:54 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so5630855eaa.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 02:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=dASam2XePeOyQqZVbFiB0uVn3hIFZo7lYX3S0C7JLbg=;
        b=kG2B8yujz0TdwnMyRER9/8EDzG+Rsv7HJJmSumGoJi9XagNAG/25ktCl7PkL3Ek4yK
         ACmmSuaOamzWhhNuyAH61xpL45e8fIz4rhh5O+7s+eAtw5b3GoFLa5Zw3+C8v0wFyoe5
         hJ5D7IH2+AlTjenFNPEA0pH8509Y7OMn5Z1ijO9zVH4azk+yqEJEYgmOBQcwZm/K04sG
         65LxNLIWd7NRqO+Ycrz+SEPD8P0h4HnGaCg+LuK0xwwWn94ARQxg5IrzEXQbc2Vw/ou+
         /hk/BCanQCuGRVQhOioU5TlhijfZVqIU/1Srpgrk6URFeW43bQQsNQ60LeyzQiqqLrC3
         06Vw==
Received: by 10.14.178.7 with SMTP id e7mr64750345eem.44.1354185112981;
        Thu, 29 Nov 2012 02:31:52 -0800 (PST)
Received: from zulu.local (cpe-62-84-224-215.dynamic.amis.net. [62.84.224.215])
        by mx.google.com with ESMTPS id k2sm2688323eep.15.2012.11.29.02.31.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 02:31:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <20121129075829.GE3424@lp-shahaf.local>
X-Gm-Message-State: ALoCoQm7ouDQyE++PEvEahoso8+SurfEZAW9vGtY2X/tiL8PFHauHM3XkSYP8YCkJ/AAdvj4Lz3B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210826>

On 29.11.2012 08:58, Daniel Shahaf wrote:
> I think you're saying that adds might turn into copies, and
> vice-versa. That is something users would notice --- it is certainly
> exposed in the UI --- even though node-id's are not exposed to client=
s.=20

=2E.. yet. But there are plans underway to expose them.

--=20
Branko =C4=8Cibej
Director of Subversion | WANdisco | www.wandisco.com
