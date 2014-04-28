From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 06/19] refs.c: make update_ref_write to return error
 string on failure
Date: Mon, 28 Apr 2014 11:23:24 -0700
Message-ID: <CAL=YDW=uavcAD==aES8zwzTstDo17paiRBhRYmYB0HkfMo8wRg@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-7-git-send-email-sahlberg@google.com>
	<20140425224507.GE9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer91-0004nA-Eg
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbaD1TXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:23:10 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:54044 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430AbaD1TXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:23:05 -0400
Received: by mail-ve0-f182.google.com with SMTP id jw12so8463381veb.41
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6Evz6+YNgL1miS4H7Wes/CGNYVwq17XdTQfBOI0e7OE=;
        b=HXeqfYdlX3SM7ajFBlu2FxDmgr3EI5FatBc5EXSEf6c4t/1mxb//uoZ8fNeACW6teB
         bw9cv0JmJ/Z2Zun5M+tLz+6gPcWuvcZgmcfAbM0c7PL1Ouv98fZPMGP/yKVJHwHUmz0R
         BPjYHBH7537vUkP3rmM8aCjCRITe7eQdA49UEx2woCgJSnZ+F2yjYIQ4mjMdADDH6Mog
         GFBcEc6/ubn0JI72CH6JQ6YaUjDSoGm/YmpEHzZ8rZO1omakdlUYz5q7C8wSQzot+amn
         jYWihYcYkBj8tu59mk6QZ/7+HgBre/vfPHarmtWt4NeUvgkawKnPrE9XHpIMmwkxEpmX
         UKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6Evz6+YNgL1miS4H7Wes/CGNYVwq17XdTQfBOI0e7OE=;
        b=GJz3un/tEVSFMeRW6f3PbN5w473DP0Mbq9hhqmHB+ZTX+j9GPMaYm9u4fWNCGdh4cm
         ABYVbCuStpt3IpHQN+aQl9NEuv4vfQ78j+2C2EvHJyoPguTpfe5jYf7QMwQVK53OHs2J
         mm4nH21fwDGWSY3WMMU6PCi2kEJuHEdyhOsBaX7mHO0FYbNptEXEytUKxaAswRQK01j+
         Yg8VYfG6MhOqGgtO87BRpv/05udIXNNIjbjKN9wPFbO/VHCSARbTO2yaJA2pavbJ5BzQ
         8Q4IcFocGPITa9cexeDTCewmnUr7DQSW7UmhagfBysA0m/0CsHOUzsMEhXweUChD72N6
         AK2Q==
X-Gm-Message-State: ALoCoQmzq7NyyZr0aUozP+f0Fcpxq8i/VVsLRSee+2xII8ItnoNdxppC76vB8eVSH1A5fDIw0wPm9pkd+rGjKZhTkHlsWAWQKJdfaRLVuFs/7vRT3xNDvvo+yC3kZjgl28HdZlF2r1X4TCRcgiVmA5qAykRsBigL09SrkzFSlLfodyfokin5L/dAKp+nBAlzEBEiAlx7TBcu
X-Received: by 10.221.34.7 with SMTP id sq7mr24904342vcb.5.1398709404158; Mon,
 28 Apr 2014 11:23:24 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 11:23:24 -0700 (PDT)
In-Reply-To: <20140425224507.GE9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247400>

Done, thanks

On Fri, Apr 25, 2014 at 3:45 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change update_ref_write to also return an error string on failure.
>> This makes the error avaialbel to ref_transaction_commit callers if the
>> transaction failed dur to update_ref_sha1/write_ref_sha1 failures.
>
> Nits:
>
>  * available
>  * during
>
> Probably should come right after or before patch 3.  Same nit as patch
> 3 about using asprintf or passing in a pointer to strbuf.
