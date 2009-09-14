From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rename tracking and file-name swapping
Date: Mon, 14 Sep 2009 08:44:37 +0200
Message-ID: <4AADE655.60503@viscovery.net>
References: <wavexx-2ECE7F.13171313092009@ger.gmane.org> <7viqfmsoej.fsf@alter.siamese.dyndns.org> <1248088D-85CB-4335-AD8A-07DB5BAD1AAA@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernardo Innocenti <bernie@codewiz.org>
To: Yuri D'Elia <wavexx@users.sf.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 08:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn5Iu-0007Iv-UD
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 08:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbZINGok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 02:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZINGoj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 02:44:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17251 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZINGoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 02:44:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mn5Ik-0003re-CK; Mon, 14 Sep 2009 08:44:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4B15C9F88; Mon, 14 Sep 2009 08:44:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1248088D-85CB-4335-AD8A-07DB5BAD1AAA@users.sf.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128439>

Yuri D'Elia schrieb:
> On 13 Sep 2009, at 20:14, Junio C Hamano wrote:
>> By default, if the pathname that was present in the old version still
>> appears in the new version, that path is not considered as a candiate
>> for rename detection.  Only "X used to be there but is gone" and "Y did
>> not exist but appeared" are paired up and checked if they are similar.
>>
>> Give the command -B option, too, to break the filepair that does not
>> disappear.
> 
> That does the trick. I'm curious, is there any other use for -B besides
> rename handling?

Yes: It can make patches easier to read (just like -M and -C do) if a file
was completely rewritten. For example, look at b9dfe51c with and without
-B, and also note the "dissimilarity index" in the diff header.

-- Hannes
