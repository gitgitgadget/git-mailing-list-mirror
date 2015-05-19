From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] subdirectory tests: code cleanup, uncomment test
Date: Tue, 19 May 2015 14:45:04 -0700
Message-ID: <xmqq4mn86y3j.fsf@gitster.dls.corp.google.com>
References: <xmqqlhglbt4k.fsf@gitster.dls.corp.google.com>
	<1431983426-4346-1-git-send-email-sbeller@google.com>
	<xmqqvbfpa8ff.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ9h=Oev_mymFBRNyAGokAe8-vWh_D12VZYHTUv20Djvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 19 23:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupK4-00016q-29
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbbESVpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:45:07 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34777 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbESVpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:45:06 -0400
Received: by ieczm2 with SMTP id zm2so24936610iec.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=uWBUHyy8HI/gZRRQe786G68aBCdZlhcpRR2I20beMvY=;
        b=gM7LLaYMHXKvF/eLr3lS6VNNa7YeRNnOYntALRPp6p07o+P6JgYkJ/ped9MR2/V/P2
         SThJLDd/Qtd7yHXJK3TOV7Uf62mh/2d8ASTQrtTlgQuLA4f/zjFzkhIYdP7Ie7HvN7fg
         NwXAXOTNdZ/FAZayU7pQRpqqtB+Wnx9DkenSeD7jYIaAWOv5BXRu5glbPJJxmCd1D/94
         VeLFEr5hBi3tXHvbbFotfEaH8A+lWEIk4nqpxNI7ZyQboR9GzztJI+v3Pj81Dd+K0ByU
         nx6nSj9GLqX41wzsLnNyCE5IjFsGOsrR0yvW2VBfzYb/AiVl6emr6JOR0GCcSiYKxLKH
         PBPQ==
X-Received: by 10.107.170.66 with SMTP id t63mr36878489ioe.31.1432071906200;
        Tue, 19 May 2015 14:45:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id k74sm10879328iok.30.2015.05.19.14.45.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 14:45:05 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269409>

Stefan Beller <sbeller@google.com> writes:

> I am not happy with (historic) either, maybe "(explicit GIT_DIR)"
> is describing the test better without giving the reader the thoughts
> as you raised here?

Yeah, there are different ways for us to notice that we are in a
bare repository and (explicit GIT_DIR) may be a good label for
this.  

Thanks.
