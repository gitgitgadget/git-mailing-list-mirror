From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 2 Oct 2006 13:06:15 +0200
Message-ID: <200610021306.16037.jnareb@gmail.com>
References: <efc2no$eti$2@sea.gmane.org> <7vd59b27c4.fsf@assigned-by-dhcp.cox.net> <7vhcynxjbc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 13:06:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GULcW-0008Kx-Rf
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 13:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJBLF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 07:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWJBLF5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 07:05:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23640 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750761AbWJBLF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 07:05:56 -0400
Received: by ug-out-1314.google.com with SMTP id o38so488684ugd
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 04:05:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C41Zvv52iy1HkxsDj1sIwv2iehZXR+U12m7pLb4Ht9Xa8gE1BhRzxzWUC5dPqnugwo1vjdb1v478B8SFtP24iJGFWxNKHkxL2O+PT0AY2JbyLI3st+bmWK1D56C3A3xWsFp9j2hC01zMlFykl9zWDmM60U8bXSduiT0lhIplNxo=
Received: by 10.67.100.17 with SMTP id c17mr2698001ugm;
        Mon, 02 Oct 2006 04:05:56 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id m1sm2496460ugc.2006.10.02.04.05.55;
        Mon, 02 Oct 2006 04:05:55 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vhcynxjbc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28225>

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> ... That means that we cannot distinguish really well (at 
>>> least color) between tree and blob entries.
>>
>> Do we even say links are blue and underlined by forcing that in
>> our css?
>>
>> Doesn't leading drwxr-xr-x mean anything?
>>
>> Why is making the distinction important in the first place?
> 
> Anyhow, I was too tired to sleep after an unscheduled day-job on
> Sunday X-<, and whipped this up for fun.
> 
> -- >8 --
> [PATCH] gitweb: remove UNIXy mode bits from tree display
> 
> and replace it with an image icon for cuteness ;-).

[...]
> +td.executable {
> +  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAACVJREFUCNdjYGBgYGdgMEhgUFBgYGJgcBKAIiAbKAIUB8oyMAAANBcCqbivEbgAAAAASUVORK5CYII=);
> +  background-repeat: no-repeat;
> +}
> +
> +td.folder {
> +  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAAB1JREFUCNdjYGBgkGFgUGJgcPzA4CCABdV/ACoBAFTTBQ822ZerAAAAAElFTkSuQmCC);
> +  background-repeat: no-repeat;
> +}
> +
> +td.regular {
> +  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAABtJREFUCNdjqD/A4JDA4BDA4FDB4MCBHdX/AACO5wbfUNnbqwAAAABJRU5ErkJggg==);
> +  background-repeat: no-repeat;
> +}
> +
> +td.symlink {
> +  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAACVJREFUCNdjYGBg4G9gMEhgUFBgcBAAIQYYYlFg4ElgkG8AKgEARSsDX750+Y0AAAAASUVORK5CYII=);
> +  background-repeat: no-repeat;
> +}
> +

Wouldn't it be better to use out-of-line images? I'm not sure if all browsers
support CSS embedded images, and if all browsers can cache such images.

Perhaps we could reuse Apache's MultiView/index.html.var... err, gitweb
tries to be web server agnostic...

And what about text browsers? It would be better to use <img> element, with
alt attribute set either to old UNIX-y mode bits, and title set to the file
type... or perhaps both alt and title attributes set to file type.

>  # convert file mode in octal to symbolic file mode string
> +sub kind_class {
> +	my ($type, $mode) = @_;
> +	$mode = oct $mode;
> +	if (S_ISDIR($mode & S_IFMT)) {
> +		return 'folder';
> +	} elsif (S_ISLNK($mode)) {
> +		return 'symlink';
> +	} elsif (S_ISREG($mode)) {
> +		# git cares only about the executable bit
> +		if ($mode & S_IXUSR) {
> +			return 'executable';
> +		} else {
> +			return 'regular';
> +		};
> +	}
> +}
> +

We have file_type subroutine, which does almost the same work. It doesn't
mark file as "executable", and it uses "directory" instead of non-standard
"folder".

By the way, $type argument (parameter) is not used at all.

> @@ -1651,7 +1668,9 @@ sub git_print_tree_entry {
>  	# the mode of the entry, list is the name of the entry, an href,
>  	# and link is the action links of the entry.
>  
> -	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
> +	my $kind = kind_class($t->{'type'}, $t->{'mode'});
> +	print "<td class=\"$kind\">&nbsp;</td>\n";
> +
>  	if ($t->{'type'} eq "blob") {
>  		print "<td class=\"list\">" .
>  			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},

-- 
Jakub Narebski
Poland
