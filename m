From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 21:52:55 +0200
Message-ID: <4F736C17.4000403@ira.uka.de>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com> <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de> <7vmx70v8ho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyur-0001uU-U3
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758552Ab2C1TwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:52:17 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:60299 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758501Ab2C1TwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 15:52:16 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SCyuY-0000X6-Es; Wed, 28 Mar 2012 21:52:12 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SCyuY-0003T5-90; Wed, 28 Mar 2012 21:52:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vmx70v8ho.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1332964332.430080000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194177>

On 28.03.2012 21:19, Junio C Hamano wrote:
> Holger Hellmuth<hellmuth@ira.uka.de>  writes:
>
>> I don't think it's that tricky:

I was assuming this "tricky" was about a sensible user interface.

>> ...
>> The tricky part might be sorting the hunks so that conflicts are first
>> (depending on how the code works now), choosing the right version in a
>> hunk (the three new options) should be relatively easy.
>
> Code it and then tell us if it is tricky or not.  Until then, especially
> when you have to say "depending on how the code works now", implying you
> do not know, why should we even listen to you?

As it is perl I'm already looking at it. I'll try to find out if my 
meagre programming skills can do something here.
