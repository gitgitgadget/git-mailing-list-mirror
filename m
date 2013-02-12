From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Improve 'git help' with basic user guide linkss
Date: Tue, 12 Feb 2013 12:00:17 -0000
Organization: OPDS
Message-ID: <6A83E216C322496CB2DEDFB2A68FE28F@PhilipOakley>
References: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley> <7vr4kqzfw5.fsf@alter.siamese.dyndns.org> <6BC280F5827C4098BCB6276232DDE8E4@PhilipOakley> <7v6222za9x.fsf@alter.siamese.dyndns.org> <27C7EA38DDD345F994F01E5B8FB6D278@PhilipOakley> <2DFA2C4F62AE484681753EBC3774D222@PhilipOakley> <20130212113731.GA13501@farnsworth.metanate.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
To: "John Keeping" <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 13:00:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5EXT-0007Qh-Mi
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 13:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044Ab3BLMAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 07:00:17 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:42728 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758515Ab3BLMAQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2013 07:00:16 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhQKAD8tGlFcHls+/2dsb2JhbABEjAq0HQOBChdzghoFAQEFCAEBLh4BASELAgMFAgEDFQECCSUUAQQaBgcXBhMIAgECAwGIBa8MkBGOMwGCcmEDiDCFV4k6jzaDBg
X-IronPort-AV: E=Sophos;i="4.84,648,1355097600"; 
   d="scan'208";a="418381085"
Received: from host-92-30-91-62.as13285.net (HELO PhilipOakley) ([92.30.91.62])
  by out1.ip02ir2.opaltelecom.net with SMTP; 12 Feb 2013 12:00:14 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216149>

From: "John Keeping" <john@keeping.me.uk>
Sent: Tuesday, February 12, 2013 11:37 AM
> On Tue, Feb 12, 2013 at 11:11:17AM -0000, Philip Oakley wrote:
>> Obviously (?) this is generated from the command-list.txt file, 
>> though I
>> don't see a shell script that would generate the
>> 'cmds-mainporcelain.txt' (etc.) files
>> (//github.com/gitster/git-htmldocs). They are also part of the 
>> msysgit
>> install.
>>
>> Where should I be looking to see how they are generated?
>
> Documentation/cmd-list.perl
>
> If you look in Documentation/Makefile, cmds-mainporcelain.txt is a
> member of cmds_txt, which depends on cmd-list.made, which is a stamp
> file created after invoking cmd-list.perl.
>
>
> John

Many thanks - some easy reading while unwell ;-) 
