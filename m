From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 15 Jul 2008 01:20:55 +0200
Message-ID: <487BDF57.4090900@gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.o
 rg> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <487BDD56.7010505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXMk-0003Ed-82
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbYGNXU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756596AbYGNXU6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:20:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:28493 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbYGNXU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:20:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2183478fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=oCtGHR2h1Nox1fQjGDvjPCh7bsPscn2zpz8cUuIPs/Y=;
        b=s+kdgvMJiRGa2OWzWU11aC3v8dfj4RmQNCZW8l+xYbQ5CPY7f9NdxUUI0PM/R1o5ma
         tB2XN/fDAQ41pfqfkvf/4nMddhdpfyUJ4khy9Dnj16AfaIoVKwkjOX8yYKy32oE2tEVm
         EK9OR1LfmwKAxDY67XyhoYVFvhAVaOqE3O0EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=p9Q0SLVxm5dAeGNB36GWPSpzCjzIFguVBj9y/5w07jyUHhtEztNFe4GjMlKyXOOKvg
         2VPQ9g04GEbB10CHBD0q6S0P9fiA0WCKQUZ/W0GgLTq2tsMreky/ymFrGjnlybHCyiRI
         jhGxRCiAsijURN6PRWce0R3mHKocDhzQFHvis=
Received: by 10.86.96.18 with SMTP id t18mr15082390fgb.17.1216077656153;
        Mon, 14 Jul 2008 16:20:56 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id l19sm3210984fgb.7.2008.07.14.16.20.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 16:20:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <487BDD56.7010505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88479>

Lea Wiemann wrote:
> It'll be fixed in the next version I post

By the way Junio, how do you prefer to get reposts of patch sequences?
Should I repost the whole sequence under a new common parent message, or
can I simply post v2 of each patch in the sequence as a followup to its
respective v1?
