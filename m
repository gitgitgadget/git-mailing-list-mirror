Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B747F2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 21:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbcGTVUk (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:20:40 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37862 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbcGTVUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:20:38 -0400
Received: by mail-wm0-f47.google.com with SMTP id i5so83236wmg.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 14:20:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dXG4aocKeksSid9Hv9qQHD3K2EWJ2pduTyYU0WdB3eo=;
        b=M3hZG0gYMfnmWh/QUn+spIVqol98UEv2f8IpUUHSMjHAH5P2UVJirIMNmO1QAKYoGs
         0D/Vz6A0Uzlhrdu0ow/8byS40l7ldR5YX1I/W/bKDQKmDgWyehxNBzNm4G/D+obTO43/
         sPP6Xoy2PHfTw6sHEdzlTqxKY+a6VJDq/oWs8WzO0bQNNPznN5Wr+Fba+MOUXfxRtDHY
         mNdPeYOjZN74JqfkFS0z+G8ppv3E/JIikkqZNCvKLQ3xiwSTHYo7a3bvXz3cgBE1KulY
         y6t0t7nl/n+yprEzYXC2TU72kiP3WpiwIR2bs/Aa7Ej5Y+FslplMJNVELQrw9MpA7Edd
         Wwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dXG4aocKeksSid9Hv9qQHD3K2EWJ2pduTyYU0WdB3eo=;
        b=D86ghInCrgGK7vhF6rz2+E6TpA0braFG5psZzTqjRcGQdLfcyIEdx0mA8JmHFMnyXK
         bOqLGdpib1Vd9P5Ra9OHlkV4QhBYeEgbG+FM7h78QflcXcmGiGl5m18JvgdVoAcxHs0T
         RtD1pQAGru7jFdeLx+2ekXLVo9b54b4pdTezHDTb/2Po+/de8RuMcOfAfhhqtqb4hW3g
         fDDMlMJGgBVJrq/ya1XunDmU6a0hICnVWTJNhVj3YYPHf/OGKMsuhB8mxM+n9AjZvCWf
         OXl57C466XeaKu+FqmXASc3L604Dq3A49aj8eCKVQuUC5b9IOMr4ZEBKCUn59LKpM1mV
         7KFA==
X-Gm-Message-State: ALyK8tK/F/ylEuogivHdLAj0zMTjYJnHCUSUwl6sqQuRcepdr2ppd18XPMXRinhVFxXzHw==
X-Received: by 10.194.100.196 with SMTP id fa4mr3954321wjb.149.1469049636416;
        Wed, 20 Jul 2016 14:20:36 -0700 (PDT)
Received: from [192.168.1.26] (daf247.neoplus.adsl.tpnet.pl. [83.23.5.247])
        by smtp.googlemail.com with ESMTPSA id qq6sm3043796wjc.34.2016.07.20.14.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 14:20:35 -0700 (PDT)
Subject: Re: Complex gitweb URL
To:	CLOSE Dave <Dave.Close@us.thalesgroup.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <225e6ff4-178c-cd2a-6a05-b621f0ad4a84@us.thalesgroup.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578FEB1E.5060302@gmail.com>
Date:	Wed, 20 Jul 2016 23:20:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <225e6ff4-178c-cd2a-6a05-b621f0ad4a84@us.thalesgroup.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 21:24, CLOSE Dave pisze:
> I'm trying to create a URL that will always refer to the latest version 
> of a file stored under Gerrit. gitweb access is available. The man page 
> specification doesn't seem to work for me. Instead, I seem to need to 
> put most of the information into arguments (after the '?').
> 
> For example, the repo name includes several directories, so it doesn't 
> work to put it into the 
> ".../gitweb.cgi/<repo>/<action>/<revision>:/<path>?<arguments>" format. 
> Or, at least, I don't see how.

The fact that gitweb path_info-based URL uses <repo>/<action>... instead
of <action>/<repo> is in my opinion a bit of an unfortunate design error,
kept because of backward compatibility.

That said, gitweb can detect where the <repo> part ends and <action>
part begins, even for hierarchical multi-part repository name. See e.g.
http://repo.or.cz/git/zerocommit.git/tree/HEAD:/Documentation with
repository part being 'git/zerocommit.git' (a "fork" of git.git). So it
should work.

There are some cases however where the URL cannot be represented in
path_info form, and some parameters must be put as query arguments,
i.e. after '?'.

> 
> Instead I'm trying to use a URL in the format, 
> "http://site/gitweb/?args". If I use gitweb itself to navigate to my 
> target file, I see a URL in this format that contains several arguments, 
> "p=repo;a=blob;f=file;h=SHA;hb=SHA". If I use that URL directly, I get 
> my file. But those SHA values are not something I know how to determine 
> in advance. And I suspect they are unique to the specific version of the 
> file accessed, not always the latest as I want.
> 
> If I replace the hb=SHA argument with hb=HEAD, the URL still works. But 
> I have no idea what I can use to replace the h=SHA argument.

You can remove it.  'hb' (hash_base) and 'f' (filename) identify target
file in a repository unambiguously.

> 
> A complication is that the target file is not in the master branch. 
> Somehow I need to be able to specify the branch. I've tried putting it 
> as the h= argument but that results in "Reading blob failed". If I leave 
> out the h= argument entirely, gitweb responds, "404 cannot find file".

Did you forgot to set 'hb' parameter?  Is said file present in revision
given by the 'hb' parameter?

See e.g. http://repo.or.cz/?p=git/zerocommit.git;a=tree;hb=master;f=t
 
> Are these arguments documented somewhere? What is the recommended way to 
> construct a URL like I need?

Well, they are not described in the documentation, but you can check
the code and its comments.

Best,
-- 
Jakub Narębski

