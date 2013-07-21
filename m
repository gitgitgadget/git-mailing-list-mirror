From: Andreas Amann <a.amann@ucc.ie>
Subject: Re: [PATCH] gitk: Add a "Save file as" menu item
Date: Sun, 21 Jul 2013 20:53:39 +0100
Message-ID: <87zjtfhepo.fsf@msstf091.ucc.ie>
References: <87ppuculyi.fsf@msstf091.ucc.ie> <alpine.DEB.2.00.1307211910250.9615@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Jul 21 21:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0zhY-0007H8-2r
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 21:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab3GUTxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 15:53:48 -0400
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:33524 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755934Ab3GUTxr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 15:53:47 -0400
Received: from mail90-tx2-R.bigfish.com (10.9.14.252) by
 TX2EHSOBE001.bigfish.com (10.9.40.21) with Microsoft SMTP Server id
 14.1.225.22; Sun, 21 Jul 2013 19:53:46 +0000
Received: from mail90-tx2 (localhost [127.0.0.1])	by mail90-tx2-R.bigfish.com
 (Postfix) with ESMTP id 5A0A22A027E;	Sun, 21 Jul 2013 19:53:46 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:143.239.1.24;KIP:(null);UIP:(null);IPV:NLI;H:mail4.ucc.ie;RD:mail4.ucc.ie;EFVD:NLI
X-SpamScore: -2
X-BigFish: VPS-2(zz148cI1432Izz1f42h208ch1ee6h1de0h1d18h1fdah2073h1202h1e76h1d1ah1d2ah1fc6hzz1de098h1de097hz2fh2a8h668h839hd24he5bhf0ahfa3h107ah11b5h121eh1288h12a5h12a9h12bdh12e5h137ah13b6h1441h14afh1504h1537h153bh162dh1631h1758h18e1h1946h19b5h1b0ah1d0ch1d2eh1d3fh1dfeh1dffh1e1dh1155h)
Received-SPF: pass (mail90-tx2: domain of ucc.ie designates 143.239.1.24 as permitted sender) client-ip=143.239.1.24; envelope-from=a.amann@ucc.ie; helo=mail4.ucc.ie ;mail4.ucc.ie ;
Received: from mail90-tx2 (localhost.localdomain [127.0.0.1]) by mail90-tx2
 (MessageSwitch) id 1374436423971639_27944; Sun, 21 Jul 2013 19:53:43 +0000
 (UTC)
Received: from TX2EHSMHS033.bigfish.com (unknown [10.9.14.231])	by
 mail90-tx2.bigfish.com (Postfix) with ESMTP id DFB9A46005B;	Sun, 21 Jul 2013
 19:53:43 +0000 (UTC)
Received: from mail4.ucc.ie (143.239.1.24) by TX2EHSMHS033.bigfish.com
 (10.9.99.133) with Microsoft SMTP Server (TLS) id 14.1.225.23; Sun, 21 Jul
 2013 19:53:41 +0000
Received: from msstf091.ucc.ie (msstf091.ucc.ie [143.239.76.91])	by
 mail4.ucc.ie (8.14.4/8.14.4) with ESMTP id r6LJrd87027194;	Sun, 21 Jul 2013
 20:53:39 +0100
Received: by msstf091.ucc.ie (Postfix, from userid 1000)	id 9BB5EA0939; Sun,
 21 Jul 2013 20:53:39 +0100 (IST)
In-Reply-To: <alpine.DEB.2.00.1307211910250.9615@ds9.cixit.se>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
X-OriginatorOrg: ucc.ie
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230940>

Peter Krefting <peter@softwolves.pp.se> writes:
> Andreas Amann:
>
>> +    set difffile "$diffidtext [file tail $flist_menu_file]"
>> +    set difffile [tk_getSaveFile -initialfile $difffile -title "Save file as" -parent .]
>> +    if {$difffile eq {}} {
>> +	return
>> +    }
>> +    save_file_from_commit $diffid:$flist_menu_file $difffile "revision $diffid"
>
> I might be misunderstanding the code (this is not one of my preferred 
> programming languages), but it looks like this is missing the gettext 
> markers necessary to get these strings localized.

thanks for pointing this out.  Will resend an updated patch.
