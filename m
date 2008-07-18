From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Fri, 18 Jul 2008 11:07:17 +0200
Message-ID: <200807181107.18098.jnareb@gmail.com>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com> <m363r3y42v.fsf@localhost.localdomain> <7vwsjj8t3s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Nigel Magnay" <nigel.magnay@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlwx-0005et-HL
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbYGRJH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbYGRJH1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:07:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:21722 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYGRJH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:07:26 -0400
Received: by nf-out-0910.google.com with SMTP id d3so95253nfc.21
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bZ3kSdI7uHvD9cmS/bvB0wStzapHACZ7U94KoHK5ymo=;
        b=ag6IIDQD/JR/Dk1ApObWKuV2Gs7p/CJBvDYTkfnaZXAxiU+vKg0oEzbn0N6Pcn+YcJ
         t21Q6ALjK70UzpVjpi7lzIA3thoFox04+8oy6zoK9neJpuohOFsQ79NkhWjTSJkQoAYK
         AdD9ea6NqA0iu1qF0YOY9W3xuZmBMGsYARRig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SXonrPCus/ZnM7CzbVCYxsqONatswhZTrA1wuhf28UFE43Errp6cMs7DuY5FBml8gK
         mhHOKLBZLyEZ+qNohFkwMYqfvYxBzGYieFy1ZPTwB0+2KBCCg2eaUDchvoTMcaWBl4lS
         bXpIRK1/f7D5rgBk3XBTaRN7R8PozaNRSUcLQ=
Received: by 10.210.49.7 with SMTP id w7mr2020163ebw.104.1216372045224;
        Fri, 18 Jul 2008 02:07:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.74])
        by mx.google.com with ESMTPS id b33sm1419316ika.2.2008.07.18.02.07.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 02:07:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwsjj8t3s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89012>

Junio C Hamano wrote:

> [...] It is understandable that you would
> want to script something that recurses into the submodules that you have
> checked out (or submodules that Fred wants you to look at), do the
> equivalent of "git fetch ../fred" you did at the toplevel to automate that
> step, but I very much agree with Pasky here in that it feels very wrong to
> hijack "submodule update" for it.

There were two proposals how to deal with fetching all submodules:
(a) git-submodule recursing into submodules, IIRC even with some
implementation (b) new "git submodule fetch" command.

-- 
Jakub Narebski
Poland
