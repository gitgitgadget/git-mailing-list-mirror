From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
Date: Tue, 11 Oct 2011 20:16:09 +0200
Message-ID: <201110112016.09620.jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com> <201110111739.49967.jnareb@gmail.com> <7vvcrvfmg4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 20:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgs9-0003AI-WF
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 20:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab1JKSQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 14:16:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33332 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab1JKSQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 14:16:08 -0400
Received: by bkbzt4 with SMTP id zt4so10114239bkb.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Hs13vo80R/6FjkcAvgvjqPpRnF2o1G8gog8QZMbw+xA=;
        b=Bp+OlH+SV9IO/8UdGq5AvkL48RGrCna9EUWEo8T1RNaClLitZRJuyWSQrOvTgK7MC0
         mMxQh/4pEtAJC2mHnplV2PcQ+tOPKnKtuJUtx4NKjAOj7S8pZ4V8xSVEEDfsWxQSpt9x
         KaJOOAwpPPfeF5StgSHYwLTM3EQ+3kTVhb+Lw=
Received: by 10.223.63.75 with SMTP id a11mr41097684fai.9.1318356967030;
        Tue, 11 Oct 2011 11:16:07 -0700 (PDT)
Received: from [192.168.1.13] (abwh114.neoplus.adsl.tpnet.pl. [83.8.231.114])
        by mx.google.com with ESMTPS id l8sm38772561fai.16.2011.10.11.11.16.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 11:16:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvcrvfmg4.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183317>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Tue, 11 Oct 2011, Junio C Hamano wrote:
>>
>>> I probably do not have time to look into this, but just FYI my trial merge
>>> to 'pu' of this topic is failing like this:
>>> 
>>> asciidoc: ERROR: gitweb.conf.txt: line 484: illegal style name: Default: ()
>>> asciidoc: ERROR: gitweb.conf.txt: line 494: illegal style name: Default: 300
>>
>> Damn, I thought I have fixed that.  This probably depends on AsciiDoc
>> version ("make doc" on 'master' generates a few _warnings_ for me related
>> to similar situation), but the problem is with
>>
>>   [Default: <value>]
>>
>> that was copied from gitweb/README.  But [<sth>] is an attribute list
>> (style name in simplest form), used more often in newer AsciiDoc.
>>
>> So either we have to escape '[' and ']', i.e. use {startsb} and {endsb},
>> which would reduce human-friendliness, or move to different way of marking
>> default values, e.g. _italic_.
>>
>> What do you think?
> 
> What do the other documents in the directory this file lives say?  I think
> we explain what the variables does, and add "defaults to false" or
> somesuch in the text, without any funny mark-up.

O.K., will do.

Now that reminds me that in a few situations gitweb.conf.txt uses literary
description "defaults to sth"...  I'll make the rest consistent with this.

-- 
Jakub Narebski
Poland
