From: =?UTF-8?B?S2lyaWxsIE3DvGxsZXI=?= <kirill.mueller@ivt.baug.ethz.ch>
Subject: Re: Hard reset of a subdirectory in a sparse checkout setting
Date: Sat, 23 Mar 2013 14:02:22 +0100
Message-ID: <514DA7DE.5040706@ivt.baug.ethz.ch>
References: <514C3249.7000100@ivt.baug.ethz.ch> <CACsJy8DmkMWOx-u2=trz+GTtwpbksTbCvUU+AOQYo5SrNtM2Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 14:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJO64-0003Cw-Qa
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 14:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab3CWNC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 09:02:28 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:29259 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab3CWNC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 09:02:27 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 14:02:20 +0100
Received: from [129.132.210.195] (129.132.210.195) by mail.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 14:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <CACsJy8DmkMWOx-u2=trz+GTtwpbksTbCvUU+AOQYo5SrNtM2Gw@mail.gmail.com>
X-Originating-IP: [129.132.210.195]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218915>

On 03/23/2013 10:59 AM, Duy Nguyen wrote:
> On Fri, Mar 22, 2013 at 5:28 PM, Kirill M=C3=BCller
> <kirill.mueller@ivt.baug.ethz.ch> wrote:
>> What's the proper way to do this in Git?
> I think adding --sparse to git checkout may be more user-friendly. An=
d
> it looks like a simple change. I'll make a patch soon (I need some
> time to recall how sparse checkout interacts with git-checkout).
Thanks for looking into it. Would it mean an extra switch to the=20
checkout command, or default behavior?

-Kirill
