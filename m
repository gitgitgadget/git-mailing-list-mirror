From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: two questions about the format of loose object
Date: Tue, 02 Dec 2008 10:26:42 +0800
Message-ID: <49349CE2.9080205@gmail.com>
References: <493399B7.5000505@gmail.com> <20081201121611.GC32415@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:28:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Kzb-0003yW-SW
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYLBC0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbYLBC0r
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:26:47 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:61181 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYLBC0r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:26:47 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1751617tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=MqqXrIVroBj6GkNuI7tQyy9hxhYHQ18idR1i76a8saY=;
        b=ORI0e0mvSo5UKiqf86bn60fRu7xvQ4JUf066US7e9DnVt9jTTtcQPZRK2hviXugh5h
         /Jp4V7TlntQnG2jr1oXd+QXrMPYwQJukufZ1CEr5+EOBl80gdJcF95zGaJzKLouzNJ0W
         t2+SCS47biqjCRFE1Ix9VF0tZGO3mfm2jQPic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=DjO/HjpT3WzAckdkfPmGVXkepooMQKfCm+uV7afk9D5Zrd2E4Ex1sDR5OVNDE7e+SP
         qj1kWj1ZkMz2hmgrk6BWDI5xhfyDV987a8cwxJKVQcSCTT6eiOwDRIIWDQyRDUZ0ay8o
         zJKh6QaRXALHiC6yYmAhA/fuwV2FYcu2eDh/I=
Received: by 10.110.31.5 with SMTP id e5mr17288818tie.31.1228184805780;
        Mon, 01 Dec 2008 18:26:45 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id w12sm3591769tib.10.2008.12.01.18.26.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 18:26:44 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20081201121611.GC32415@mail.local.tull.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102105>

Nick Andrew wrote:
> On Mon, Dec 01, 2008 at 04:00:55PM +0800, Liu Yubao wrote:
>> I did a simple benchmark on my notebook and a server in my company,
>> writing a big file to disk is faster than compressing it first and
>> writing the result out. The former's performance for reading should
>> also be better because of file cache.
> 
> In a corporate environment (and not related to git) I found the
> opposite. The disk was fairly slow (over NFS) and it was in fact
> quicker to read and write compressed files.
> 
> Nick.
> 
Ok, there must be exceptional cases, for these cases you can turn
off core.uncompressedLooseObject (if there will be this config).


Best regards,

Liu Yubao
