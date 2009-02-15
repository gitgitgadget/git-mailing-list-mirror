From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gitweb: fix wrong base URL when non-root 
 DirectoryIndex
Date: Sun, 15 Feb 2009 11:33:55 -0800
Message-ID: <7v8wo7lckc.fsf@gitster.siamese.dyndns.org>
References: <200902122303.37499.jnareb@gmail.com>
 <7vskmh3gtv.fsf@gitster.siamese.dyndns.org>
 <200902140342.26270.jnareb@gmail.com> <200902141104.35042.jnareb@gmail.com>
 <cb7bb73a0902140629pa1ad038pe898aa0d804d0707@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmm2-00062U-Fl
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZBOTeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZBOTeG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:34:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZBOTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:34:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FA6D9A5A7;
	Sun, 15 Feb 2009 14:34:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83ECE9A5A5; Sun,
 15 Feb 2009 14:33:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 99D3C9F6-FB97-11DD-84AA-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110040>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Sat, Feb 14, 2009 at 11:04 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> P.S. I wonder why Giuseppe's patch failed to apply, and failed
>> to do fallback 3-way merge...
>
> Because it depends on an additional quoting fix that I sent to the
> mailing list but that apparently didn't get through.
>
>> -               print '<base href="'.esc_url($my_url).'" />\n';
>> +               print '<base href="'.esc_url($base_url).'" />\n';
>
> The quoting fix was here: double quotes are needed because otherwise
> the \n gets in literally. We can probably squash it with this patch.
> Gimme a sec and I'll cook it up again.

Thanks, both.
