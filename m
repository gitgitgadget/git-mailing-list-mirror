From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/3] fetch/pull: Add the --recurse-submodules option
Date: Fri, 10 Dec 2010 19:03:42 +0100
Message-ID: <4D026B7E.3000008@web.de>
References: <4CDB3063.5010801@web.de> <20101111000538.GB14189@burratino> <4CDD391C.2000905@web.de> <7vei9qfxzy.fsf@alter.siamese.dyndns.org> <4D016146.9010907@web.de> <7vlj3xedru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 19:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR7Jt-0007f5-R6
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 19:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab0LJSDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 13:03:44 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:42040 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621Ab0LJSDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 13:03:44 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id E2546181869F4;
	Fri, 10 Dec 2010 19:03:42 +0100 (CET)
Received: from [93.246.34.120] (helo=[192.168.178.51])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PR7Jm-00058W-00; Fri, 10 Dec 2010 19:03:42 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vlj3xedru.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+lW5WWFdQmof9GvQKMcc+aTAeTuzGdzsui2/mp
	JyZut+GeuagQdzKsEQa5x7htxlmmLztkde+plyeFvcOzf/jYzE
	n+s1qXlH50P/+AIsUcgw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163423>

Am 10.12.2010 18:30, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> No, you didn't miss anything but I have been off by one ... '4' is
>> sufficient here.
> 
> Ok, thanks for double checking.
> 
> -- >8 --
> Subject: [PATCH] fetch_populated_submodules(): document dynamic allocation size

Thanks and ack.

(This was a leftover from the time the "--recurse-submodules" option had been
added in this function before I moved that into add_options_to_argv())
