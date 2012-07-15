From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sun, 15 Jul 2012 19:45:35 +0200
Message-ID: <500301BF.9080505@ira.uka.de>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com> <loom.20120714T114718-783@post.gmane.org> <7vzk725c86.fsf@alter.siamese.dyndns.org> <7vr4se5bg4.fsf@alter.siamese.dyndns.org> <CAAa3hFOv39DhuEDTyJUm1pzB-X1gBiV8FXuqW6TidOtQw9CUng@mail.gmail.com> <7vmx32590u.fsf@alter.siamese.dyndns.org> <CAAa3hFMNf_wA22ngypSu379jr31r3L3yAjTkvDUd_L-mVwPJkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	git@vger.kernel.org
To: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 19:46:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqStU-0008PN-D6
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 19:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab2GORqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 13:46:03 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:56794 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757Ab2GORqB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2012 13:46:01 -0400
Received: from dslb-088-066-028-153.pools.arcor-ip.net ([88.66.28.153] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1SqStB-0001JB-66; Sun, 15 Jul 2012 19:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAAa3hFMNf_wA22ngypSu379jr31r3L3yAjTkvDUd_L-mVwPJkA@mail.gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1342374354.796138000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201481>

Am 15.07.2012 00:24, schrieb Zeeshan Ali (Khattak):
> On Sun, Jul 15, 2012 at 12:26 AM, Junio C Hamano<gitster@pobox.com>  wrote:
>> "Zeeshan Ali (Khattak)"<zeeshanak@gnome.org>  writes:
>>
>>> What about '^' and '^^' that I suggested?

If you want a shortcut, you might try this:

echo "ref: HEAD" > .git/h

Then you can use 'h' instead of 'HEAD'.

Tested it and it seemed to work. If not someone on this list surely will 
correct me.
